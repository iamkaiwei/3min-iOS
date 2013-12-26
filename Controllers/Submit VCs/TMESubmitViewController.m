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

static CGFloat const LABEL_CONTENT_DEFAULT_HEIGHT = 26;

@interface TMESubmitViewController()
<UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate
>

@property (strong, nonatomic) NSMutableArray *arrayConversation;

@end

@interface TMESubmitViewController()

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

- (NSMutableArray *)arrayConversation{
    if (!_arrayConversation) {
        _arrayConversation = [@[] mutableCopy];
    }
    return _arrayConversation;
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
    
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeGradient];
    [self loadTransaction];
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

- (void)loadTransaction
{
    if ([self.product.user.id isEqual:[[TMEUserManager sharedInstance] loggedUser].id]) {
        [[TMETransactionManager sharedInstance] getListMessageOfProduct:self.product
                                                                 toUser:nil
                                                         onSuccessBlock:^(NSArray *arrayTransaction)
         {
             self.arrayConversation = [arrayTransaction mutableCopy];
             [self reloadTableViewConversation];
         }
                                                        andFailureBlock:^(NSInteger statusCode,id obj)
         {
             
         }];
        return;
    }
    
    [[TMETransactionManager sharedInstance] getListMessageOfProduct:self.product
                                                             toUser:self.product.user
                                                     onSuccessBlock:^(NSArray *arrayTransaction)
    {
        self.arrayConversation = [arrayTransaction mutableCopy];
        [self reloadTableViewConversation];
    }
                                                    andFailureBlock:^(NSInteger statusCode,id obj)
    {
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TMESubmitTableCell *cell = [[TMESubmitTableCell alloc] init];
    TMETransaction *transaction = self.arrayConversation[indexPath.row];
    DLog(@"%f", [cell getHeightWithContent:transaction.chat]);
    return [cell getHeightWithContent:transaction.chat];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayConversation.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TMETransaction *transaction = self.arrayConversation[indexPath.row];
    if ([transaction.from.id isEqual:[[TMEUserManager sharedInstance] loggedUser].id]) {
        TMESubmitTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMESubmitTableCell class]) forIndexPath:indexPath];
        [cell configCellWithConversation:transaction andSeller:self.product.user];
        return cell;
    }
    
    TMESubmitTableCellRight *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMESubmitTableCellRight class]) forIndexPath:indexPath];
    [cell configCellWithConversation:transaction andSeller:self.product.user];
    
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self postTransaction];
    self.txtInputMessage.text = @"";
    return YES;
}

- (void)postTransaction{
    [[TMETransactionManager sharedInstance] postMessageTo:self.product
                                              withMessage:self.txtInputMessage.text
                                           onSuccessBlock:^(TMETransaction *transaction)
    {
        [self.arrayConversation addObject:transaction];
        [self reloadTableViewConversation];
    }
                                          andFailureBlock:^(NSInteger statusCode, id obj)
    {
        DLog(@"Error: %d", statusCode);
    }];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [self addNavigationItems];
    self.navigationItem.rightBarButtonItem = nil;
    self.title = @"Your Offer";
    return YES;
}

@end
