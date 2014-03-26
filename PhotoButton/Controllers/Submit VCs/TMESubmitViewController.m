//
//  TMESubmitViewController.m
//  PhotoButton
//
//  Created by Toan Slan on 12/23/13.
//
//

#import "TMESubmitViewController.h"
#import "TMESubmitTableCell.h"
#import "TMESubmitTableCellRight.h"
#import "AppDelegate.h"
#import "HTKContainerViewController.h"
#import "TMESubmitViewControllerArrayDataSource.h"

@interface TMESubmitViewController()
<
UIApplicationDelegate,
UITextViewDelegate,
UIAlertViewDelegate,
PTPusherDelegate
>

@property (strong, nonatomic) IBOutlet   UIScrollView                * scrollViewContent;
@property (weak, nonatomic)   IBOutlet   UIImageView                 * imageViewProduct;
@property (weak, nonatomic)   IBOutlet   UILabel                     * lblProductName;
@property (weak, nonatomic)   IBOutlet   UILabel                     * lblProductPrice;
@property (weak, nonatomic)   IBOutlet   UILabel                     * lblPriceOffered;
@property (weak, nonatomic)   IBOutlet   UILabel                     * lblDealLocation;
@property (weak, nonatomic)   IBOutlet   UITextView                  * textViewInputMessage;
@property (strong, nonatomic) TMESubmitViewControllerArrayDataSource * repliesArrayDataSource;
@property (weak, nonatomic)   IBOutlet   UIButton                    * buttonMarkAsSold;
@property (strong, nonatomic) PTPusherPresenceChannel                * presenceChannel;


@end

@implementation TMESubmitViewController

#pragma mark - View controller life cycle

- (void)viewDidLoad{
    [super viewDidLoad];
    [TMEPusherManager connectWithDelegate:self];
    [TMEPusherManager authenticateUser];
    self.title = NSLocalizedString(@"You Offer", nil);
    [self registerForKeyboardNotifications];
    [self setEdgeForExtendedLayoutNone];
    self.textViewInputMessage.delegate = self;
    [self getCacheMessage];
    [self loadProductDetail];
    
    [self loadMessageWithReplyIDWithPage:1
                              showBottom:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadMessageNotification:)
                                                 name:NOTIFICATION_RELOAD_CONVERSATION
                                               object:nil];
    [self subscribeChannel];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.tabBarController.tabBar.translucent = YES;
    }
}

- (void)subscribeChannel{
    self.presenceChannel = [TMEPusherManager subscribeToPresenceChannelNamed:@"channel" delegate:nil];
    [self.presenceChannel bindToEventNamed:@"client-chat" handleWithBlock:^(PTPusherEvent *channelEvent) {
        NSDictionary *dictionary = channelEvent.data;
        NSString *name = dictionary[@"name"];
        NSString *message = dictionary[@"message"];
        [UIAlertView showAlertWithTitle:name message:message];
    }];
}

- (void)setUpTableView{
    self.repliesArrayDataSource = [[TMESubmitViewControllerArrayDataSource alloc] initWithItems:self.dataArray cellIdentifier:[TMESubmitTableCell kind] cellRightIdentifier:[TMESubmitTableCellRight kind] conversation:self.conversation paging:self.paging];
    
    self.tableView.dataSource = self.repliesArrayDataSource;
    [self.tableView reloadData];
}

- (void)registerNibForTableView{
    self.arrayCellIdentifier = @[[TMESubmitTableCell kind],[TMESubmitTableCellRight kind]];
    self.registerLoadMoreCell = YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.paging && indexPath.row == 0) {
        TMELoadMoreTableViewCell *cell = (TMELoadMoreTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        [cell startLoading];
        
        NSInteger previousPage = self.dataArray.count/10 + 1;
        [self loadMessageWithReplyIDWithPage:previousPage
                                  showBottom:NO];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.paging && indexPath.row == 0) {
        return [TMELoadMoreTableViewCell getHeight];
    }
    
    TMESubmitTableCell *cell = [[TMESubmitTableCell alloc] init];
    TMEReply *reply;
    
    if (self.paging) {
        reply = self.dataArray[indexPath.row - 1];
        return [cell getHeightWithContent:reply.reply];
    }
    
    reply = self.dataArray[indexPath.row];
    return [cell getHeightWithContent:reply.reply];
}

#pragma mark - Post message

- (void)postMessage{
    if ([self.textViewInputMessage.text isEqual: @""]) {
        return;
    }

    [self.presenceChannel triggerEventNamed:@"client-chat" data:@{@"name": [TMEUserManager sharedInstance].loggedUser.fullname,
                                                                  @"message" : self.textViewInputMessage.text}];

    TMEReply *reply = [TMEReply replyPendingWithContent:self.textViewInputMessage.text];
    [self.dataArray addObject:reply];
    [self reloadTableViewConversationShowBottom:YES];
    
    NSInteger lastestReplyID = [self getLastestReplyID];
    [TMEConversationManager postReplyToConversation:[self.conversation.id intValue]
                                        withMessage:self.textViewInputMessage.text
                                     onSuccessBlock:^(NSString *status)
     {
         if ([status isEqualToString:@"success"]) {
             [self loadMessageWithReplyIDLargerID:lastestReplyID
                                      orSmallerID:0
                                         withPage:1
                                       showBottom:YES];
         }
     }
                                       failureBlock:^(NSInteger statusCode, NSError *error)
     {
         [self.dataArray removeLastObject];
         [self reloadTableViewConversationShowBottom:NO];
         [self failureBlockHandleWithError:error];
     }];
}

#pragma mark - Load message

- (void)loadMessageWithReplyIDLargerID:(NSInteger)largerReplyID
                           orSmallerID:(NSInteger)smallerReplyID
                              withPage:(NSInteger)page
                            showBottom:(BOOL)showBottom
{
    if(![self isReachable]){
        return;
    }
    
    [TMEConversationManager getRepliesOfConversationID:[self.conversation.id intValue]
                                         largerReplyID:largerReplyID
                                        smallerReplyID:smallerReplyID
                                              withPage:page
                                        onSuccessBlock:^(TMEConversation *conversation)
     {
         self.paging = NO;
         self.conversation = conversation;
         self.dataArray = [[conversation.repliesSet allObjects] mutableCopy];
         if (self.dataArray.count % 10 == 0 && self.dataArray.count)
             self.paging = YES;
         self.dataArray = [[self.dataArray sortByAttribute:@"id" ascending:YES] mutableCopy];
         [self reloadTableViewConversationShowBottom:showBottom];
     }
                                          failureBlock:^(NSInteger statusCode, NSError *error)
     {
         [self failureBlockHandleWithError:error];
     }];
}

- (void)loadMessageWithReplyIDWithPage:(NSInteger)page
                            showBottom:(BOOL)showBottom
{
    [self loadMessageWithReplyIDLargerID:0 orSmallerID:0 withPage:page showBottom:showBottom];
    
}

#pragma mark - Helper method

- (NSInteger)getLastestReplyID{
    TMEReply *reply = (TMEReply *)[self.dataArray lastObject];
    return [reply.id integerValue];
}

- (void)handleMarkAsSoldButtonTitle{
    if (self.product.sold_outValue) {
        self.buttonMarkAsSold.enabled = NO;
        [self.buttonMarkAsSold setTitle:NSLocalizedString(@"Sold", nil) forState:UIControlStateNormal];
        return;
    }
    
    if (![self.product.user.id isEqual:[[TMEUserManager sharedInstance] loggedUser].id]) {
        self.buttonMarkAsSold.enabled = NO;
        [self.buttonMarkAsSold setTitle:NSLocalizedString(@"Selling", nil) forState:UIControlStateNormal];
    }
}

- (void)loadProductDetail{
    if ([self.textViewInputMessage respondsToSelector:@selector(setTintColor:)]) {
        [self.textViewInputMessage setTintColor:[UIColor orangeMainColor]];
    }
    self.lblProductName.text = self.product.name;
    self.lblProductPrice.text = [NSString stringWithFormat:@"%@ VND",self.product.price];
    
    [self.imageViewProduct setImageWithURL:[NSURL URLWithString:[[[self.product.images allObjects] lastObject] thumb]]];
    
    self.lblPriceOffered.text = [NSString stringWithFormat:@"%@ VND",self.conversation.offer];
    [self handleMarkAsSoldButtonTitle];
}

- (void)reloadTableViewConversationShowBottom:(BOOL)showBottom{
    [self setUpTableView];
    self.tableView.height = self.tableView.contentSize.height;
    [self.textViewInputMessage alignBelowView:self.tableView offsetY:10 sameWidth:YES];
    [self.textViewInputMessage setHeight:35.5];
    [self.scrollViewContent autoAdjustScrollViewContentSize];
    
    CGPoint bottomOffset = CGPointMake(0, 0);
    if (showBottom && self.scrollViewContent.contentSize.height > self.scrollViewContent.height) {
        if (!self.isKeyboardShowing) {
            bottomOffset = CGPointMake(0, self.scrollViewContent.contentSize.height - CGRectGetHeight(self.scrollViewContent.bounds));
        }
        else{
            bottomOffset = CGPointMake(0, self.scrollViewContent.contentSize.height - CGRectGetHeight(self.scrollViewContent.bounds) + 166);
        }
        [self.scrollViewContent setContentOffset:bottomOffset animated:YES];
    }
    
    [self finishLoading];
}

- (void)getCacheMessage{
    self.conversation = [[TMEConversation MR_findByAttribute:@"id" withValue:self.conversation.id] lastObject];
    self.dataArray = [[self.conversation.repliesSet allObjects] mutableCopy];
    if (self.dataArray.count) {
        self.dataArray = [[self.dataArray sortByAttribute:@"id" ascending:YES] mutableCopy];
        [self reloadTableViewConversationShowBottom:NO];
    }
}

#pragma mark - Remote Notification

- (void)reloadMessageNotification:(NSNotification *)sender{
    [self loadMessageWithReplyIDLargerID:[self getLastestReplyID]
                             orSmallerID:0
                                withPage:1
                              showBottom:YES];
}

#pragma mark - Text view delegate

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.frame.size.height == 111.5) {
        return;
    }
    
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    textView.frame = newFrame;
    
    [self.scrollViewContent autoAdjustScrollViewContentSize];
    [self.scrollViewContent scrollSubviewToCenter:textView animated:NO];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]) {
        if(![self isReachable]){
            return NO;
        }
        [self postMessage];
        [textView setText:@""];
        [self.scrollViewContent scrollSubviewToCenter:textView animated:NO];
        return NO;
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [self addNavigationItems];
    self.navigationItem.rightBarButtonItem = nil;
    self.title = NSLocalizedString(@"You Offer", nil);
    
    if ([textView.text isEqualToString:@""]) {
        textView.textColor = [UIColor lightGrayColor];
        textView.text = NSLocalizedString(@"Type message here to chat...", nil);
    }
    
    return YES;
}

#pragma mark - Navigation back button override

- (void)onBtnBack{
    UIViewController *root = self.navigationController.viewControllers[0];
    if ([root isKindOfClass:[HTKContainerViewController class]]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Override KeyboardShowNotification

- (void)onKeyboardWillShowNotification:(NSNotification *)sender{
    self.isKeyboardShowing = YES;
    
    NSValue *keyboardFrame = [[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize kbSize = [keyboardFrame CGRectValue].size;
    NSTimeInterval duration = [[[sender userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions animationCurve = [[[sender userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateWithDuration:duration delay:0 options:animationCurve animations:^{
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, kbSize.height - 50, 0);
        [self.scrollViewContent setContentInset:edgeInsets];
        [self.scrollViewContent setScrollIndicatorInsets:edgeInsets];
    } completion:nil];
    self.deckController.panningMode = IIViewDeckNoPanning;
}

- (IBAction)btnMarkAsSoldPressed:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Confirm", nil)
                                                    message:NSLocalizedString(@"Do you want to Mark as sold your product?", nil)
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"No", nil)
                                          otherButtonTitles:NSLocalizedString(@"Yes", nil), nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex) {
        [TMEProductsManager putSoldOutWithProductID:self.product.id
                                     onSuccessBlock:nil
                                       failureBlock:nil];
    }
}

- (void)pusher:(PTPusher *)pusher willAuthorizeChannel:(PTPusherChannel *)channel withRequest:(NSMutableURLRequest *)request{
    [request setValue:[NSString stringWithFormat:@"Bearer %@",[[TMEUserManager sharedInstance] getAccessToken]] forHTTPHeaderField:@"Authorization"];
}

#pragma mark - Handle changing reachability

- (void)reachabilityDidChange:(NSNotification *)notification {
    
    if ([TMEReachabilityManager isReachable]) {
        if (![TMEReachabilityManager sharedInstance].lastState) {
            [TSMessage showNotificationWithTitle:NSLocalizedString(@"Connected", nil) type:TSMessageNotificationTypeSuccess];
        }
        [self loadMessageWithReplyIDWithPage:1 showBottom:YES];
        [TMEReachabilityManager sharedInstance].lastState = 1;
        return;
    }
    if ([TMEReachabilityManager sharedInstance].lastState) {
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"No connection!", nil) type:TSMessageNotificationTypeError];
        [TMEReachabilityManager sharedInstance].lastState = 0;
    }
}

@end
