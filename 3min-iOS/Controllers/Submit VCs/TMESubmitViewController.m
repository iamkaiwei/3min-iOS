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
PTPusherDelegate,
PTPusherPresenceChannelDelegate
>

@property (weak, nonatomic)   IBOutlet   UIImageView                 * imageViewProduct;
@property (weak, nonatomic)   IBOutlet   UILabel                     * lblProductName;
@property (weak, nonatomic)   IBOutlet   UILabel                     * lblProductPrice;
@property (weak, nonatomic)   IBOutlet   UILabel                     * lblPriceOffered;
@property (weak, nonatomic)   IBOutlet   UILabel                     * lblDealLocation;
@property (weak, nonatomic)   IBOutlet   UITextView                  * textViewInputMessage;
@property (weak, nonatomic)   IBOutlet   UIButton                    * buttonMarkAsSold;
@property (weak, nonatomic)   IBOutlet   UILabel                     * labelTyping;

@property (strong, nonatomic) IBOutlet   UIScrollView                * scrollViewContent;
@property (strong, nonatomic) TMESubmitViewControllerArrayDataSource * repliesArrayDataSource;
@property (strong, nonatomic) PTPusherPresenceChannel                * presenceChannel;
@property (strong, nonatomic) NSMutableArray                         * arrayClientReplies;
@property (assign, nonatomic) enum TMEChatMode                       currentChatMode;
@property (assign, nonatomic) BOOL                                   isTyping;

@end

@implementation TMESubmitViewController

- (NSMutableArray *)arrayClientReplies{
    if (!_arrayClientReplies) {
        _arrayClientReplies = [[NSMutableArray alloc] init];
    }
    return _arrayClientReplies;
}

#pragma mark - View controller life cycle

- (void)viewDidLoad{
    [super viewDidLoad];
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
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [TMEPusherManager connectWithDelegate:self];
    [self subscribeChannel];
    self.currentChatMode = TMEChatModeOffline;
    self.isTyping = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.tabBarController.tabBar.translucent = YES;
    }
    [self.presenceChannel unsubscribe];
    [TMEPusherManager disconnect];
    if (self.arrayClientReplies.count) {
        [self postMessagesToServer];
    }
}

- (void)subscribeChannel{
//    self.presenceChannel = [TMEPusherManager subscribeToPresenceChannelNamed:self.conversation.channelName delegate:self];
//    [self.presenceChannel bindToEventNamed:PUSHER_CHAT_EVENT_NAME                           handleWithBlock:^(PTPusherEvent *channelEvent) {
//        self.labelTyping.text = @"";
//        TMEUser *user = [TMEUser userWithID:self.conversation.userID
//                                   fullName:self.conversation.userFullname
//                                  photoURL:self.conversation.userAvatar];
//
//        TMEReply *reply = [TMEReply replyWithContent:channelEvent.data[@"message"]
//                                              sender:user
//                                           timeStamp:channelEvent.data[@"timestamp"]];
//        [self.dataArray addObject:reply];
//        [self reloadTableViewConversationShowBottom:YES];
//    }];
//
//    [self.presenceChannel bindToEventNamed:PUSHER_CHAT_EVENT_TYPING handleWithBlock:^(PTPusherEvent *channelEvent) {
//        self.labelTyping.text = channelEvent.data[@"text"];
//        [self.labelTyping performSelector:@selector(setText:)
//                               withObject:@""
//                               afterDelay:15.0f];
//    }];
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
    
    if (self.paging) {
        TMEReply *reply = self.dataArray[indexPath.row - 1];
        NSLog(@"%f", [cell getHeightWithContent:reply.reply]);
        return [cell getHeightWithContent:reply.reply];
    }
    
    TMEReply *reply = self.dataArray[indexPath.row];
    NSLog(@"%f", [cell getHeightWithContent:reply.reply]);
    return [cell getHeightWithContent:reply.reply];
}

#pragma mark - Post message

- (void)postMessage{
    if ([self.textViewInputMessage.text isEqual: @""]) {
        return;
    }
    self.isTyping = NO;

    if (self.currentChatMode == TMEChatModeOnline) {
        double currentTimeStamp = [[NSDate date] timeIntervalSince1970];
        [self.presenceChannel triggerEventNamed:PUSHER_CHAT_EVENT_NAME
                                           data:@{@"name": [TMEUserManager sharedManager].loggedUser.fullName,
                                                  @"message" : self.textViewInputMessage.text,
                                                  @"timestamp" : @(currentTimeStamp)}];
        TMEReply *reply = [TMEReply replyWithContent:self.textViewInputMessage.text
                                              sender:[TMEUserManager sharedManager].loggedUser
                                           timeStamp:@(currentTimeStamp)];
        [self.dataArray addObject:reply];
        [self.arrayClientReplies addObject:@{ @"reply": self.textViewInputMessage.text,
                                              @"created_at": @(currentTimeStamp) }];
        if (self.arrayClientReplies.count == 20) {
            [self postMessagesToServer];
        }
        [self reloadTableViewConversationShowBottom:YES];
        return;
    }

    TMEReply *reply = [TMEReply replyPendingWithContent:self.textViewInputMessage.text];
    [self.dataArray addObject:reply];
    [self reloadTableViewConversationShowBottom:YES];
    
    NSInteger lastestReplyID = [self getLastestReplyID];
    [TMEConversationManager postReplyToConversation:[self.conversation.conversationID intValue]
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
                                       failureBlock:^(NSError *error)
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
    
    [TMEConversationManager getRepliesOfConversationID:[self.conversation.conversationID intValue]
                                         largerReplyID:largerReplyID
                                        smallerReplyID:smallerReplyID
                                              withPage:page
                                        onSuccessBlock:^(TMEConversation *conversation)
     {
         self.paging = NO;
         if (largerReplyID) {
             [self.dataArray removeLastObject];
             [self.dataArray addObjectsFromArray:conversation.replies];
             self.conversation.replies = self.dataArray;
         }
         else if (smallerReplyID) {
             [self.dataArray insertObjects:conversation.replies atIndexes:[NSIndexSet indexSetWithIndex:0]];
             self.conversation.replies = self.dataArray;
         }
         else {
             self.dataArray = [conversation.replies mutableCopy];
             self.conversation = conversation;
         }
         if (self.dataArray.count % 10 == 0 && self.dataArray.count)
             self.paging = YES;
         self.dataArray = [[self.dataArray sortByAttribute:@"timeStamp" ascending:YES] mutableCopy];
         [self reloadTableViewConversationShowBottom:showBottom];
     }
                                          failureBlock:^(NSError *error)
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
    return [[self.dataArray valueForKeyPath:@"@max.replyID"] integerValue];
}

- (void)handleMarkAsSoldButtonTitle{
    if (self.product.soldOut) {
        self.buttonMarkAsSold.enabled = NO;
        [self.buttonMarkAsSold setTitle:NSLocalizedString(@"Sold", nil) forState:UIControlStateNormal];
        return;
    }
    
    if (![self.product.user.userID isEqual:[TMEUserManager sharedManager].loggedUser.userID]) {
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
    
    [self.imageViewProduct setImageWithURL:[[self.product.images lastObject] thumbURL]];
    
    self.lblPriceOffered.text = [NSString stringWithFormat:@"%@ VND",self.conversation.offer];
    [self handleMarkAsSoldButtonTitle];
}

- (void)reloadTableViewConversationShowBottom:(BOOL)showBottom{
    [self setUpTableView];
    self.tableView.height = self.tableView.contentSize.height;
    [self.labelTyping alignBelowView:self.tableView offsetY:10 sameWidth:YES];
    [self.textViewInputMessage alignBelowView:self.labelTyping offsetY:10 sameWidth:YES];
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
//    self.conversation = [[TMEConversation MR_findByAttribute:@"id" withValue:self.conversation.id] lastObject];
//    self.dataArray = [self.conversation.replies mutableCopy];
//    if (self.dataArray.count) {
//        self.dataArray = [[self.dataArray sortByAttribute:@"time_stamp" ascending:YES] mutableCopy];
//        [self reloadTableViewConversationShowBottom:NO];
//    }
}

- (void)postMessagesToServer{
    if (![self isReachable]) {
        return;
    }

    [TMEConversationManager createBulkWithConversationID:self.conversation.conversationID
                                           arrayMessages:self.arrayClientReplies
                                          onSuccessBlock:^()
    {
        [self.arrayClientReplies removeAllObjects];
    }
                                            failureBlock:^(NSError *error)
    {
        DLog(@"%@", error);
    }];
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

    if (textView.text.length > 0 && !self.isTyping && self.currentChatMode == TMEChatModeOnline) {
        [self.presenceChannel triggerEventNamed:PUSHER_CHAT_EVENT_TYPING
                                           data:@{@"text" : [NSString stringWithFormat:@"%@ is typing...", [TMEUserManager sharedManager].loggedUser.fullName]}];
        self.isTyping = YES;
    }

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
        [TMEProductsManager putSoldOutWithProductID:self.product.productID
                                     onSuccessBlock:nil
                                       failureBlock:nil];
    }
}

- (void)pusher:(PTPusher *)pusher willAuthorizeChannel:(PTPusherChannel *)channel withRequest:(NSMutableURLRequest *)request{
    [request setValue:[NSString stringWithFormat:@"Bearer %@",[TMEUserManager sharedManager].loggedUser.accessToken] forHTTPHeaderField:@"Authorization"];
}

- (void)presenceChannelDidSubscribe:(PTPusherPresenceChannel *)channel{
    if (channel.members.count == 2) {
        self.currentChatMode = TMEChatModeOnline;
    };
}

- (void)presenceChannel:(PTPusherPresenceChannel *)channel memberAdded:(PTPusherChannelMember *)member{
    self.currentChatMode = TMEChatModeOnline;
    [TSMessage showNotificationWithTitle:[NSString stringWithFormat:@"%@ is online!", member.userInfo[@"name"]] type:TSMessageNotificationTypeSuccess];
}

- (void)presenceChannel:(PTPusherPresenceChannel *)channel memberRemoved:(PTPusherChannelMember *)member{
    self.currentChatMode = TMEChatModeOffline;
    if (self.arrayClientReplies.count) {
        [self postMessagesToServer];
    }
    [TSMessage showNotificationWithTitle:[NSString stringWithFormat:@"%@ is offline!", self.conversation.userFullname] type:TSMessageNotificationTypeError];
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
