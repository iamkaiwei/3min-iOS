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

static CGFloat const LABEL_CONTENT_DEFAULT_HEIGHT = 26;
static NSInteger const kUserID = 36;

@interface TMESubmitViewController()
<UITableViewDataSource,
UITableViewDelegate,
UIApplicationDelegate,
UITextFieldDelegate
>

@property (strong, nonatomic)            TMEUser                                * buyer;
@property (strong, nonatomic)            NSMutableArray                         * arrayReply;
@property (strong, nonatomic) IBOutlet   UIScrollView                           * scrollView;
@property (weak, nonatomic)   IBOutlet   UIImageView                            * imageViewProduct;
@property (weak, nonatomic)   IBOutlet   UILabel                                * lblProductName;
@property (weak, nonatomic)   IBOutlet   UILabel                                * lblProductPrice;
@property (weak, nonatomic)   IBOutlet   UILabel                                * lblPriceOffered;
@property (weak, nonatomic)   IBOutlet   UILabel                                * lblDealLocation;
@property (weak, nonatomic)   IBOutlet   UITableView                            * tableViewConversation;
@property (weak, nonatomic)   IBOutlet   UITextField                            * txtInputMessage;


@end

@implementation TMESubmitViewController

- (NSMutableArray *)arrayReply{
  if (!_arrayReply) {
    _arrayReply = [@[] mutableCopy];
  }
  return _arrayReply;
}

#pragma mark - View controller life cycle

- (void)viewDidLoad{
  [super viewDidLoad];
  self.title = @"You Offer";
  
  [self registerForKeyboardNotifications];
  
  [self.tableViewConversation registerNib:[UINib nibWithNibName:NSStringFromClass([TMESubmitTableCell class]) bundle:Nil] forCellReuseIdentifier:NSStringFromClass([TMESubmitTableCell class])];
  [self.tableViewConversation registerNib:[UINib nibWithNibName:NSStringFromClass([TMESubmitTableCellRight class]) bundle:Nil] forCellReuseIdentifier:NSStringFromClass([TMESubmitTableCellRight class])];
  
  self.txtInputMessage.delegate = self;
  UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 14, 20)];
  self.txtInputMessage.leftView = paddingView;
  self.txtInputMessage.leftViewMode = UITextFieldViewModeAlways;
  
  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
    self.edgesForExtendedLayout = UIRectEdgeNone;
  }
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(reloadMessageNotification:)
                                               name:NOTIFICATION_RELOAD_CONVERSATION
                                             object:nil];
  [self getCacheMessage];
  [self loadProductDetail];
  
  if (!self.arrayReply.count) {
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeGradient];
  }
  if (self.conversation) {
    [self loadMessageWithReplyIDLargerID:0 orSmallerID:0 withPage:1 ShowBottom:NO];
    return;
  }
  [self loadConversationShowBottom:NO];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Table view datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  TMESubmitTableCell *cell = [[TMESubmitTableCell alloc] init];
  TMEReply *reply = self.arrayReply[indexPath.row];
  return [cell getHeightWithContent:reply.reply];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.arrayReply.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  TMEReply *reply = self.arrayReply[indexPath.row];
  if ([reply.user_id isEqual:[[[TMEUserManager sharedInstance] loggedUser] id]]) {
    reply.user_full_name = [[[TMEUserManager sharedInstance] loggedUser] fullname];
    reply.user_avatar = [[[TMEUserManager sharedInstance] loggedUser] photo_url];
    TMESubmitTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMESubmitTableCell class]) forIndexPath:indexPath];
    [cell configCellWithMessage:reply];
    return cell;
  }
  
  reply.user_full_name = self.conversation.user_full_name;
  reply.user_avatar = self.conversation.user_avatar;
  TMESubmitTableCellRight *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMESubmitTableCellRight class]) forIndexPath:indexPath];
  [cell configCellWithMessage:reply];
  
  return cell;
}

#pragma mark - Post message

- (void)postMessage{
  if ([self.txtInputMessage.text isEqual: @""]) {
    return;
  }
  
  TMEReply *reply = [TMEReply replyPendingWithContent:self.txtInputMessage.text];
  [self.arrayReply addObject:reply];
  [self reloadTableViewConversationShowBottom:YES];

  NSInteger lastestReplyID = [self getLastestReplyID];
  [[TMEConversationManager sharedInstance] postReplyToConversation:[self.conversation.id intValue]
                                                       withMessage:self.txtInputMessage.text
                                                    onSuccessBlock:^(NSString *status){
                                                      if ([status isEqualToString:@"success"]) {
                                                        [self loadMessageWithReplyIDLargerID:lastestReplyID
                                                                                 orSmallerID:0
                                                                                    withPage:1
                                                                                  ShowBottom:NO];
                                                      }
                                                    }
                                                   andFailureBlock:^(NSInteger statusCode, id obj){
                                                       [self.arrayReply removeLastObject];
                                                       DLog(@"Error: %d", statusCode);
                                                       if (statusCode == -1011) {
                                                           [self showAlertForLongMessageContent];
                                                      }
                                                    }];
}

#pragma mark - Load message

- (void)loadMessageWithReplyIDLargerID:(NSInteger)largerReplyID
                           orSmallerID:(NSInteger)smallerReplyID
                              withPage:(NSInteger)page
                            ShowBottom:(BOOL)showBottom
{
  [[TMEConversationManager sharedInstance] getRepliesOfConversationWithConversationID:[self.conversation.id intValue]
                                                                   andReplyIDLargerID:largerReplyID
                                                                          orSmallerID:smallerReplyID
                                                                             withPage:page
                                                                       onSuccessBlock:^(TMEConversation *conversation)
   {
     self.conversation = conversation;
       if (!largerReplyID) {
           self.arrayReply = [[conversation.repliesSet allObjects] mutableCopy];
       }
       else
       {
           [self.arrayReply addObjectsFromArray:[[conversation.repliesSet allObjects] mutableCopy]];
       }
     self.arrayReply = [[self sortArrayReplies:self.arrayReply] mutableCopy];
     [self reloadTableViewConversationShowBottom:showBottom];
   }
                                                                      andFailureBlock:^(NSInteger statusCode,id obj)
   {
     return DLog(@"%d", statusCode);
   }];
}

#pragma mark - Load conversation

- (void)loadConversationShowBottom:(BOOL)showBottom{
  [[TMEConversationManager sharedInstance] getConversationWithProductID:self.product.id
                                                               toUserID:self.product.user.id
                                                         onSuccessBlock:^(TMEConversation *conversation){
                                                           self.conversation = conversation;
                                                           if (conversation.replies.count) {
                                                             self.arrayReply = [[conversation.repliesSet allObjects] mutableCopy];
                                                             self.arrayReply = [[self sortArrayReplies:self.arrayReply] mutableCopy];
                                                           }
                                                           [self reloadTableViewConversationShowBottom:showBottom];
                                                         }
                                                        andFailureBlock:^(NSInteger statusCode, id obj){
                                                          DLog(@"%d",statusCode);
                                                        
                                                        }];
}

#pragma mark - Helper method

- (BOOL)isSeller
{
  if ([[[TMEUserManager sharedInstance] loggedUser].id isEqual:self.product.user.id]) {
    return YES;
  }
  return NO;
}

- (NSArray *)sortArrayReplies:(NSArray *)array{
  NSSortDescriptor *sortDescriptor;
  sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id"
                                               ascending:YES];
  NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
  NSArray *sortedArray = [array sortedArrayUsingDescriptors:sortDescriptors];
  return sortedArray;
}

- (NSInteger)getLastestReplyID{
  TMEReply *reply = (TMEReply *)[self.arrayReply lastObject];
  return [reply.id integerValue];
}

- (void)loadProductDetail
{
  self.lblProductName.text = self.product.name;
  self.lblProductPrice.text = [NSString stringWithFormat:@"$%@",self.product.price];
  [self.imageViewProduct setImageWithURL:[NSURL URLWithString:[[self.product.images anyObject] thumb]]];
  self.lblPriceOffered.text = [NSString stringWithFormat:@"$%@",self.product.price];
}

- (void)reloadTableViewConversationShowBottom:(BOOL)showBottom{
  [self.tableViewConversation reloadData];
  self.tableViewConversation.height = self.tableViewConversation.contentSize.height;
  [self.txtInputMessage alignBelowView:self.tableViewConversation offsetY:10 sameWidth:YES];
  [self autoAdjustScrollViewContentSize];
  
  
  if (showBottom) {
    CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - CGRectGetHeight(self.scrollView.bounds));
    [self.scrollView setContentOffset:bottomOffset animated:YES];
  }
  
  [SVProgressHUD dismiss];
}

- (void)showAlertForLongMessageContent{
  [self.arrayReply removeObject:[self.arrayReply lastObject]];
  [self reloadTableViewConversationShowBottom:YES];
  [UIAlertView showAlertWithTitle:@"Error" message:@"The text is too long!"];
}

- (void)getCacheMessage{
//  TMEConversation *conversation = [TMEConversation alloc];
//  if (self.conversationID) {
//    conversation = [[TMEConversation MR_findByAttribute:@"id" withValue:@(self.conversationID)]lastObject];
//  }
//  
//  self.arrayReply = [[conversation.replies allObjects] mutableCopy];
//  if (self.arrayReply.count) {
//    self.arrayReply = [[self sortArrayReplies:self.arrayReply] mutableCopy];
//    [self reloadTableViewConversationShowBottom:YES];
//  }
}

#pragma mark - Remote Notification

- (void)reloadMessageNotification:(NSNotification *)sender{
    [self loadMessageWithReplyIDLargerID:[self getLastestReplyID] orSmallerID:0 withPage:1 ShowBottom:YES];
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
  [self postMessage];
  self.txtInputMessage.text = @"";
  [self.scrollView scrollSubviewToCenter:self.txtInputMessage animated:YES];
  return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
  [self addNavigationItems];
  self.navigationItem.rightBarButtonItem = nil;
  self.title = @"Your Offer";
  return YES;
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
    [self.scrollView setContentInset:edgeInsets];
    [self.scrollView setScrollIndicatorInsets:edgeInsets];
  } completion:nil];
}

#pragma mark - Handle changing reachability

- (void)reachabilityDidChange:(NSNotification *)notification {
  
  if ([TMEReachabilityManager isReachable]) {
    if (![TMEReachabilityManager sharedInstance].lastState) {
      [TSMessage showNotificationWithTitle:@"Connected" type:TSMessageNotificationTypeSuccess];
    }
    [self loadMessageWithReplyIDLargerID:0 orSmallerID:0 withPage:1 ShowBottom:YES];
    [TMEReachabilityManager sharedInstance].lastState = 1;
    return;
  }
  if ([TMEReachabilityManager sharedInstance].lastState) {
    [TSMessage showNotificationWithTitle:@"No connection" type:TSMessageNotificationTypeError];
    [TMEReachabilityManager sharedInstance].lastState = 0;
  }
}

@end
