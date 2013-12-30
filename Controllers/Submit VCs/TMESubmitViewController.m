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

@property (strong, nonatomic) TMEUser *buyer;
@property (strong, nonatomic) NSMutableArray *arrayMessage;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewProduct;
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblProductPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblPriceOffered;
@property (weak, nonatomic) IBOutlet UILabel *lblDealLocation;
@property (weak, nonatomic) IBOutlet UITableView *tableViewConversation;
@property (weak, nonatomic) IBOutlet UITextField *txtInputMessage;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation TMESubmitViewController

- (NSMutableArray *)arrayMessage{
    if (!_arrayMessage) {
        _arrayMessage = [@[] mutableCopy];
    }
    return _arrayMessage;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"You Offer";
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
                                             selector:@selector(loadMessage)
                                                 name:NOTIFICATION_RELOAD_CONVERSATION
                                               object:nil];
    
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeGradient];
    [self loadMessage];
    [self loadProductDetail];
}

- (void)loadProductDetail
{
    self.lblProductName.text = self.product.name;
    self.lblProductPrice.text = [NSString stringWithFormat:@"$%@",self.product.price];
    [self.imageViewProduct setImageWithURL:[NSURL URLWithString:[[self.product.images anyObject] thumb]]];
    self.lblPriceOffered.text = [NSString stringWithFormat:@"$%@",self.product.price];
}

- (void)reloadTableViewConversation{
    [self.tableViewConversation reloadData];
    [self.tableViewConversation setHeight:self.tableViewConversation.contentSize.height];
    [self.txtInputMessage alignBelowView:self.tableViewConversation offsetY:10 sameWidth:YES];
    [self autoAdjustScrollViewContentSize];
    
    [SVProgressHUD dismiss];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TMESubmitTableCell *cell = [[TMESubmitTableCell alloc] init];
    TMEMessage *message = self.arrayMessage[indexPath.row];
    DLog(@"%f", [cell getHeightWithContent:message.chat]);
    return [cell getHeightWithContent:message.chat];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayMessage.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TMEMessage *message = self.arrayMessage[indexPath.row];
    if ([message.from.id isEqual:[[TMEUserManager sharedInstance] loggedUser].id]) {
        TMESubmitTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMESubmitTableCell class]) forIndexPath:indexPath];
        [cell configCellWithMessage:message andSeller:self.product.user];
        return cell;
    }
    
    TMESubmitTableCellRight *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMESubmitTableCellRight class]) forIndexPath:indexPath];
    [cell configCellWithMessage:message andSeller:self.product.user];
    
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self postMessage];
    self.txtInputMessage.text = @"";
    [self.scrollView autoPushUpAllElements];
    return YES;
}

- (void)postMessage{
    if (self.txtInputMessage.text) {
        if ([self isSeller]) {
            [[TMEMessageManager sharedInstance] postMessageTo:self.buyer
                                                       forProduct:self.product
                                                      withMessage:self.txtInputMessage.text
                                                   onSuccessBlock:^(TMEMessage *message)
             {
                 if (message) {
                     [self.arrayMessage addObject:message];
                     [self loadMessage];
                 }
             }
                                                  andFailureBlock:^(NSInteger statusCode, id obj)
             {
                 return;
             }];
            return;
        }
        [[TMEMessageManager sharedInstance] postMessageTo:self.product.user
                                                   forProduct:self.product
                                                  withMessage:self.txtInputMessage.text
                                               onSuccessBlock:^(TMEMessage *message)
         {
             [self.arrayMessage addObject:message];
             [self loadMessage];
         }
                                              andFailureBlock:^(NSInteger statusCode, id obj)
         {
             DLog(@"Error: %d", statusCode);
         }];
    }
}

- (void)loadMessageWithBuyer:(TMEUser *)buyer toUser:(TMEUser *)user
{
    [[TMEMessageManager sharedInstance] getListMessageOfProduct:self.product
                                                          fromBuyer:buyer
                                                             toUser:user
                                                     onSuccessBlock:^(NSArray *arrayMessage)
     {
         self.arrayMessage = [arrayMessage mutableCopy];
         [self reloadTableViewConversation];
     }
                                                    andFailureBlock:^(NSInteger statusCode,id obj)
     {
         return;
     }];
}

- (void)loadMessage
{
    if ([self isSeller]) {
        NSNumber *userID = @(kUserID);
        TMEUser* buyerCache = [[TMEUser MR_findByAttribute:@"id" withValue:userID] lastObject];
        self.buyer = buyerCache;
        
        if (buyerCache) {
            [self loadMessageWithBuyer:buyerCache toUser:buyerCache];
            return;
        }
        
        [[TMEUserManager sharedInstance] getUserWithID:userID onSuccess:^(TMEUser *buyer)
         {
             self.buyer = buyer;
             [self loadMessageWithBuyer:self.buyer
                                   toUser:self.buyer];
             
         } andFailure:^(NSInteger statusCode, NSError *error)
         {
             return;
         }];
        return;
    }
    
    self.buyer = [[TMEUserManager sharedInstance] loggedUser];
    [self loadMessageWithBuyer:self.buyer toUser:self.product.user];
}

- (BOOL)isSeller
{
    if ([[[TMEUserManager sharedInstance] loggedUser].id isEqual:self.product.user.id]) {
        return YES;
    }
    return NO;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [self addNavigationItems];
    self.navigationItem.rightBarButtonItem = nil;
    self.title = @"Your Offer";
    return YES;
}

- (void)reachabilityDidChange:(NSNotification *)notification {
    
    if ([TMEReachabilityManager isReachable]) {
        if (![TMEReachabilityManager sharedInstance].lastState) {
            [TSMessage showNotificationWithTitle:@"Connected" type:TSMessageNotificationTypeSuccess];
        }
        [self loadMessage];
        [TMEReachabilityManager sharedInstance].lastState = 1;
        return;
    }
    if ([TMEReachabilityManager sharedInstance].lastState) {
        [TSMessage showNotificationWithTitle:@"No connection" type:TSMessageNotificationTypeError];
        [TMEReachabilityManager sharedInstance].lastState = 0;
    }
}

@end
