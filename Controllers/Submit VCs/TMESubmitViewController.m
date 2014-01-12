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
#import "TMELoadMoreTableViewCell.h"
#import "AppDelegate.h"

static CGFloat const LABEL_CONTENT_DEFAULT_HEIGHT = 26;
static NSInteger const kUserID = 36;

@interface TMESubmitViewController()
<UITableViewDataSource,
UITableViewDelegate,
UIApplicationDelegate,
UITextViewDelegate,
TMELoadMoreTableViewCellDelegate
>

@property (strong, nonatomic)            NSMutableArray                         * arrayReply;
@property (strong, nonatomic) IBOutlet   UIScrollView                           * scrollViewContent;
@property (weak, nonatomic)   IBOutlet   UIImageView                            * imageViewProduct;
@property (weak, nonatomic)   IBOutlet   UILabel                                * lblProductName;
@property (weak, nonatomic)   IBOutlet   UILabel                                * lblProductPrice;
@property (weak, nonatomic)   IBOutlet   UILabel                                * lblPriceOffered;
@property (weak, nonatomic)   IBOutlet   UILabel                                * lblDealLocation;
@property (weak, nonatomic)   IBOutlet   UITableView                            * tableViewConversation;
@property (weak, nonatomic)   IBOutlet   UITextView                             * textViewInputMessage;

@end

@implementation TMESubmitViewController

- (NSMutableArray *)arrayReply{
  if (!_arrayReply) {
    _arrayReply = [NSMutableArray array];
  }
  return _arrayReply;
}

#pragma mark - View controller life cycle

- (void)viewDidLoad{
  [super viewDidLoad];
  self.title = @"You Offer";
  
  [self registerForKeyboardNotifications];
  
  self.tabBarController.tabBar.hidden = NO;
  
  [self.tableViewConversation registerNib:[UINib nibWithNibName:NSStringFromClass([TMESubmitTableCell class]) bundle:Nil] forCellReuseIdentifier:NSStringFromClass([TMESubmitTableCell class])];
  [self.tableViewConversation registerNib:[UINib nibWithNibName:NSStringFromClass([TMESubmitTableCellRight class]) bundle:Nil] forCellReuseIdentifier:NSStringFromClass([TMESubmitTableCellRight class])];
  
  self.textViewInputMessage.delegate = self;
  
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
    [self loadMessageWithReplyIDLargerID:0 orSmallerID:0 withPage:1 showBottom:NO];
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
  if ([self havePreviousReply] && indexPath.row == 0) {
        return [TMELoadMoreTableViewCell getHeight];
  }
  
  TMESubmitTableCell *cell = [[TMESubmitTableCell alloc] init];
  TMEReply *reply;
  
  if ([self havePreviousReply]) {
     reply = self.arrayReply[indexPath.row - 1];
  }
  else{
    reply = self.arrayReply[indexPath.row];
  }
  
  return [cell getHeightWithContent:reply.reply];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  if ([self havePreviousReply]) {
    return self.arrayReply.count + 1;
  }
  
  return self.arrayReply.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  TMEReply *reply;
  if ([self havePreviousReply] && indexPath.row == 0) {
    
    TMELoadMoreTableViewCell *cellLoadMore = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMELoadMoreTableViewCell class])];
    if (cellLoadMore == nil) {
      // Load the top-level objects from the custom cell XIB.
      NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TMELoadMoreTableViewCell class]) owner:self options:nil];
      // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
      cellLoadMore = [topLevelObjects objectAtIndex:0];
    }
    cellLoadMore.delegate = self;
    
    return cellLoadMore;
  }
  
  if ([self havePreviousReply]) {
    reply = self.arrayReply[indexPath.row - 1];
  }
  else{
    reply = self.arrayReply[indexPath.row];
  }
  
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
  if ([self.textViewInputMessage.text isEqual: @""]) {
    return;
  }
  
  TMEReply *reply = [TMEReply replyPendingWithContent:self.textViewInputMessage.text];
  [self.arrayReply addObject:reply];
  [self reloadTableViewConversationShowBottom:YES];

  NSInteger lastestReplyID = [self getLastestReplyID];
  [[TMEConversationManager sharedInstance] postReplyToConversation:[self.conversation.id intValue]
                                                       withMessage:self.textViewInputMessage.text
                                                    onSuccessBlock:^(NSString *status){
                                                      if ([status isEqualToString:@"success"]) {
                                                        [self loadMessageWithReplyIDLargerID:lastestReplyID
                                                                                 orSmallerID:0
                                                                                    withPage:1
                                                                                  showBottom:NO];
                                                      }
                                                    }
                                                   andFailureBlock:^(NSInteger statusCode, id obj){
                                                       [self.arrayReply removeLastObject];
                                                       DLog(@"Error: %d", statusCode);
                                                       if (self.textViewInputMessage.text.length > 200) {
                                                           [self showAlertForLongMessageContent];
                                                      }
                                                    }];
}

#pragma mark - Load message

- (void)loadMessageWithReplyIDLargerID:(NSInteger)largerReplyID
                           orSmallerID:(NSInteger)smallerReplyID
                              withPage:(NSInteger)page
                            showBottom:(BOOL)showBottom
{
  [[TMEConversationManager sharedInstance] getRepliesOfConversationWithConversationID:[self.conversation.id intValue]
                                                                   andReplyIDLargerID:largerReplyID
                                                                          orSmallerID:smallerReplyID
                                                                             withPage:page
                                                                       onSuccessBlock:^(TMEConversation *conversation)
   {
     self.conversation = conversation;
       if (!largerReplyID && !smallerReplyID) {
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

- (BOOL)isSeller{
  if ([[[TMEUserManager sharedInstance] loggedUser].id isEqual:self.product.user.id]) {
    return YES;
  }
  return NO;
}

- (BOOL)havePreviousReply{
  if (self.arrayReply.count % 10 == 0 && self.arrayReply.count) {
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

- (void)loadProductDetail{
  self.lblProductName.text = self.product.name;
  self.lblProductPrice.text = [NSString stringWithFormat:@"$%@",self.product.price];
  [self.imageViewProduct setImageWithURL:[NSURL URLWithString:[[self.product.images anyObject] thumb]]];
  self.lblPriceOffered.text = [NSString stringWithFormat:@"$%@",self.product.price];
}

- (void)reloadTableViewConversationShowBottom:(BOOL)showBottom{
  [self.tableViewConversation reloadData];
self.tableViewConversation.height = self.tableViewConversation.contentSize.height;
  [self.textViewInputMessage alignBelowView:self.tableViewConversation offsetY:10 sameWidth:YES];
  [self.textViewInputMessage setHeight:35.5];
  [self.scrollViewContent autoAdjustScrollViewContentSize];
  
  if (showBottom) {
    CGPoint bottomOffset = CGPointMake(0, self.scrollViewContent.contentSize.height);
    [self.scrollViewContent setContentOffset:bottomOffset animated:YES];
  }
  
  [SVProgressHUD dismiss];
}

- (void)showAlertForLongMessageContent{
  [self.arrayReply removeObject:[self.arrayReply lastObject]];
  [self reloadTableViewConversationShowBottom:YES];
  [UIAlertView showAlertWithTitle:@"Error" message:@"The text is too long!"];
}

- (void)getCacheMessage{
  self.conversation = [[TMEConversation MR_findByAttribute:@"id" withValue:self.conversation.id] lastObject];
  self.arrayReply = [self.conversation.repliesSet mutableCopy];
  if (self.arrayReply.count) {
    self.arrayReply = [[self sortArrayReplies:self.arrayReply] mutableCopy];
    [self reloadTableViewConversationShowBottom:YES];
  }
}

- (void)onBtnLoadMore:(UIButton *)sender{
  NSInteger previousPage = self.arrayReply.count/10 + 1;
  [self loadMessageWithReplyIDLargerID:0
                           orSmallerID:0
                              withPage:previousPage
                            showBottom:NO];
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
  self.title = @"Your Offer";
  
  textView.textColor = [UIColor lightGrayColor];
  textView.text = @"Type message here to chat...";
  
  return YES;
}

#pragma mark - Navigation back button override

- (void)onBtnBack{
  [self.navigationController popToRootViewControllerAnimated:YES];
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
}

#pragma mark - Handle changing reachability

- (void)reachabilityDidChange:(NSNotification *)notification {
  
  if ([TMEReachabilityManager isReachable]) {
    if (![TMEReachabilityManager sharedInstance].lastState) {
      [TSMessage showNotificationWithTitle:@"Connected" type:TSMessageNotificationTypeSuccess];
    }
    [self loadMessageWithReplyIDLargerID:0 orSmallerID:0 withPage:1 showBottom:YES];
    [TMEReachabilityManager sharedInstance].lastState = 1;
    return;
  }
  if ([TMEReachabilityManager sharedInstance].lastState) {
    [TSMessage showNotificationWithTitle:@"No connection" type:TSMessageNotificationTypeError];
    [TMEReachabilityManager sharedInstance].lastState = 0;
  }
}

@end
