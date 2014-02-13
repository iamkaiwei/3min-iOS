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
#import "TMESubmitViewControllerArrayDataSource.h"

static NSString * const SubmitCellIdentifier = @"TMESubmitTableCell";
static NSString * const SubmitRightCellIdentifier = @"TMESubmitTableCellRight";
static NSString * const LoadMoreCellIdentifier = @"TMELoadMoreTableViewCell";
static CGFloat const LABEL_CONTENT_DEFAULT_HEIGHT = 26;
static NSInteger const kUserID = 36;

@interface TMESubmitViewController()
<UITableViewDataSource,
UITableViewDelegate,
UIApplicationDelegate,
UITextViewDelegate
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
@property (strong, nonatomic) TMESubmitViewControllerArrayDataSource *repliesArrayDataSource;


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
  
  [self disableNavigationTranslucent];
  
  self.textViewInputMessage.delegate = self;
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(reloadMessageNotification:)
                                               name:NOTIFICATION_RELOAD_CONVERSATION
                                             object:nil];
  [self getCacheMessage];
  [self loadProductDetail];
  
  if ([TMEReachabilityManager isReachable]) {
    if (!self.arrayReply.count) {
      [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeGradient];
    }
    
    if (self.conversation) {
      [self loadMessageWithReplyIDLargerID:0
                               orSmallerID:0
                                  withPage:1
                                showBottom:YES];
    }
    return;
  }
  
  [self reloadTableViewConversationShowBottom:NO];
  [SVProgressHUD showErrorWithStatus:@"No connection!"];
}

- (void)setUpTableView{
  self.repliesArrayDataSource = [[TMESubmitViewControllerArrayDataSource alloc] initWithItems:self.arrayReply cellIdentifier:SubmitCellIdentifier cellRightIdentifier:SubmitRightCellIdentifier conversation:self.conversation paging:self.paging];
  self.tableViewConversation.dataSource = self.repliesArrayDataSource;
}

- (void)registerNibForTableView{
  self.tableView = self.tableViewConversation;
  self.arrayCellIdentifier = @[SubmitCellIdentifier,SubmitRightCellIdentifier,LoadMoreCellIdentifier];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  if (self.paging && indexPath.row == 0) {
    TMELoadMoreTableViewCell *cell = (TMELoadMoreTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.indicatorLoading.color = [UIColor whiteColor];
    [cell startLoading];
    
    NSInteger previousPage = self.arrayReply.count/10 + 1;
    [self loadMessageWithReplyIDLargerID:0
                             orSmallerID:0
                                withPage:previousPage
                              showBottom:NO];
  } 
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  if (self.paging && indexPath.row == 0) {
        return [TMELoadMoreTableViewCell getHeight];
  }
  
  TMESubmitTableCell *cell = [[TMESubmitTableCell alloc] init];
  TMEReply *reply;
  
  if (self.paging) {
     reply = self.arrayReply[indexPath.row - 1];
    return [cell getHeightWithContent:reply.reply];
  }
  
  reply = self.arrayReply[indexPath.row];
  return [cell getHeightWithContent:reply.reply];
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
                                                                                  showBottom:YES];
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
     self.paging = NO;
     self.conversation = conversation;
     self.arrayReply = [[conversation.repliesSet allObjects] mutableCopy];
     if (self.arrayReply.count % 10 == 0 && self.arrayReply.count)
       self.paging = YES;
     self.arrayReply = [[self.arrayReply sortByAttribute:@"id" ascending:YES] mutableCopy];
     [self reloadTableViewConversationShowBottom:showBottom];
   }
                                                                      andFailureBlock:^(NSInteger statusCode,id obj)
   {
     return DLog(@"%d", statusCode);
   }];
}

#pragma mark - Helper method

- (NSInteger)getLastestReplyID{
  TMEReply *reply = (TMEReply *)[self.arrayReply lastObject];
  return [reply.id integerValue];
}

- (void)loadProductDetail{
  if ([[UITextView appearance] respondsToSelector:@selector(setTintColor:)]) {
      [[UITextView appearance] setTintColor:[UIColor orangeMainColor]];
  }
  self.lblProductName.text = self.product.name;
  self.lblProductPrice.text = [NSString stringWithFormat:@"$%@",self.product.price];
  [self.imageViewProduct setImageWithURL:[NSURL URLWithString:[[[self.product.images allObjects] lastObject] thumb]]];
  self.lblPriceOffered.text = [NSString stringWithFormat:@"$%@",self.conversation.offer];
}

- (void)reloadTableViewConversationShowBottom:(BOOL)showBottom{
  [self setUpTableView];
  [self.tableViewConversation reloadData];
  self.tableViewConversation.height = self.tableViewConversation.contentSize.height;
  [self.textViewInputMessage alignBelowView:self.tableViewConversation offsetY:10 sameWidth:YES];
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
  [SVProgressHUD dismiss];
}

- (void)showAlertForLongMessageContent{
  [self.arrayReply removeObject:[self.arrayReply lastObject]];
  [self reloadTableViewConversationShowBottom:YES];
  [UIAlertView showAlertWithTitle:@"Error" message:@"The text is too long!"];
}

- (void)getCacheMessage{
  self.conversation = [[TMEConversation MR_findByAttribute:@"id" withValue:self.conversation.id] lastObject];
  self.arrayReply = [[self.conversation.repliesSet allObjects] mutableCopy];
  if (self.arrayReply.count) {
    self.arrayReply = [[self.arrayReply sortByAttribute:@"id" ascending:YES] mutableCopy];
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
    if (![TMEReachabilityManager isReachable]) {
      [SVProgressHUD showErrorWithStatus:@"No connection!"];
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
  self.title = @"Your Offer";
  
  if ([textView.text isEqualToString:@""]) {
    textView.textColor = [UIColor lightGrayColor];
    textView.text = @"Type message here to chat...";
  }
  
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
