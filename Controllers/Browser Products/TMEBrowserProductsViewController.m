//
//  TMEBrowerProductsViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "TMEBrowserProductsViewController.h"
#import "TMEBrowserProductsTableCell.h"
#import "TMESubmitViewController.h"
#import "TMEProductDetailsViewController.h"
#import "TMEBrowserProductTableViewHeader.h"
#import "TMEBrowserProductsViewControllerArrayDataSource.h"

static NSString * const kBrowseProductCellIdentifier = @"TMEBrowserProductsTableCell";
static NSString * const kBrowseProductHeaderIdentifier = @"TMEBrowserProductTableViewHeader";

@interface TMEBrowserProductsViewController ()
<
UIScrollViewDelegate,
UITableViewDelegate,
TMEBrowserProductsTableCellDelegate
>

@property (strong, nonatomic) TMEUser                   * loginUser;
@property (strong, nonatomic) TMECategory               * currentCategory;
@property (strong, nonatomic) TMEBrowserProductsViewControllerArrayDataSource    * productsArrayDataSource;
@property (weak, nonatomic) IBOutlet UIImageView        * imageViewProductPlaceholder;
@property (weak, nonatomic) IBOutlet MTAnimatedLabel    * labelAnimated;
@end

@implementation TMEBrowserProductsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  [self.labelAnimated startAnimating];
  self.navigationController.navigationBar.topItem.title = @"Browse Products";
  [[XLCircleProgressIndicator appearance] setStrokeProgressColor:[UIColor orangeMainColor]];
  [[XLCircleProgressIndicator appearance] setStrokeRemainingColor:[UIColor whiteColor]];
  [[XLCircleProgressIndicator appearance] setStrokeWidth:3.0f];
  
  [self.tableView registerNib:[UINib nibWithNibName:kBrowseProductHeaderIdentifier bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:kBrowseProductHeaderIdentifier];
  self.scrollableView = self.tableView;
  [self enablePullToRefresh];
  [self paddingScrollWithTop];
  [self loadProducts];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(onCategoryChangeNotification:)
                                               name:CATEGORY_CHANGE_NOTIFICATION
                                             object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  [self setUpTableView];
}

- (void)registerNibForTableView{
  self.arrayCellIdentifier = @[kBrowseProductCellIdentifier];
}

- (void)setUpTableView{
  self.productsArrayDataSource = [[TMEBrowserProductsViewControllerArrayDataSource alloc] initWithItems:self.dataArray cellIdentifier:kBrowseProductCellIdentifier headerIdentifier:kBrowseProductHeaderIdentifier delegate:self];
  
  self.tableView.dataSource = self.productsArrayDataSource;
  [self refreshTableViewAnimated:NO];
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  TMEProductDetailsViewController *productDetailsController = [[TMEProductDetailsViewController alloc] init];
  productDetailsController.product = self.dataArray[indexPath.row];
  productDetailsController.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:productDetailsController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  TMEBrowserProductTableViewHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kBrowseProductHeaderIdentifier];
  [header configHeaderWithData:self.dataArray[section]];
  
  return header;
}

#pragma mark - Load Product

- (void)loadProducts{
  if (![TMEReachabilityManager isReachable]) {
    [SVProgressHUD showErrorWithStatus:@"No connection!"];
    [self.pullToRefreshView endRefreshing];
    return;
  }
  [SVProgressHUD showWithStatus:@"Loading products..." maskType:SVProgressHUDMaskTypeGradient];
  if (self.currentCategory) {
    [[TMEProductsManager sharedInstance] getProductsOfCategory:self.currentCategory
                                                onSuccessBlock:^(NSArray *arrProducts)
     {
       [self hidePlaceHolder];
       self.dataArray = [arrProducts mutableCopy];
       [self setUpTableView];
       [self.pullToRefreshView endRefreshing];
       [self.tableView setContentOffset:CGPointMake(0, -60) animated:YES];
       [SVProgressHUD dismiss];
     } andFailureBlock:^(NSInteger statusCode, id obj) {
       [self.pullToRefreshView endRefreshing];
       [SVProgressHUD dismiss];
     }];
  } else {
    [[TMEProductsManager sharedInstance] getAllProductsOnSuccessBlock:^(NSArray *arrProducts) {
      [self hidePlaceHolder];
      self.dataArray = [arrProducts mutableCopy];
      [self setUpTableView];
      [SVProgressHUD dismiss];
      
      [self.pullToRefreshView endRefreshing];
    } andFailureBlock:^(NSInteger statusCode, id obj) {
      [self.pullToRefreshView endRefreshing];
      [SVProgressHUD dismiss];
    }];
  }
}


#pragma mark - SSPullToRefreshView delegate
- (void)pullToRefreshViewDidStartLoading:(UIRefreshControl *)view
{
  if (![TMEReachabilityManager isReachable]) {
    [SVProgressHUD showErrorWithStatus:@"No connection!"];
    [self.pullToRefreshView endRefreshing];
    return;
  }
  
  self.pullToRefreshView.attributedTitle = [[NSAttributedString alloc]initWithString:[NSString getLastestUpdateString]];
  [self loadProducts];
}

#pragma mark - Utilities
- (void)paddingScrollWithTop
{
  if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
    CGFloat scrollViewTopInset = 44;
    self.tableView.contentInset = UIEdgeInsetsMake(scrollViewTopInset, 0, 0, 0);
  }
}

#pragma mark - Notifications
- (void)onCategoryChangeNotification:(NSNotification *)notification
{
  NSDictionary *userInfo = [notification userInfo];
  self.currentCategory = [userInfo objectForKey:@"category"];
  self.navigationController.navigationBar.topItem.title = self.currentCategory.name;
  [self loadProducts];
}

#pragma mark - Button Like Action
- (void)onBtnLike:(UIButton *)sender label:(UILabel *)label{
  UIView *superView = sender.superview;
  
  while (nil != sender.superview) {
    if ([superView isKindOfClass:[UITableViewCell class]]) {
      break;
    }
    superView = superView.superview;
  }
  
  NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)superView];
  TMEProduct *currentCellProduct = self.dataArray[indexPath.row];
  sender.selected = !currentCellProduct.likedValue;
  
  if (!currentCellProduct.likedValue) {
    [[TMEProductsManager sharedInstance] likeProductWithProductID:currentCellProduct.id
                                                   onSuccessBlock:nil
                                                  andFailureBlock:^(NSInteger statusCode, NSError *error){
                                                    [self likeProductFailureHandleButtonLike:sender currentCellProduct:currentCellProduct label:label unlike:NO];
                                                  }];
    currentCellProduct.likedValue = YES;
    currentCellProduct.likesValue++;
    label.text = [@(label.text.integerValue + 1) stringValue];
    return;
  }
  
  [[TMEProductsManager sharedInstance] unlikeProductWithProductID:currentCellProduct.id
                                                   onSuccessBlock:nil
                                                  andFailureBlock:^(NSInteger statusCode, NSError *error){
                                                    [self likeProductFailureHandleButtonLike:sender currentCellProduct:currentCellProduct label:label unlike:YES];
                                                  }];
  currentCellProduct.likedValue = NO;
  currentCellProduct.likesValue--;
  label.text = [@(label.text.integerValue - 1) stringValue];
}

- (void)likeProductFailureHandleButtonLike:(UIButton *)sender currentCellProduct:(TMEProduct *)currentCellProduct label:(UILabel *)label unlike:(BOOL)flag{
  [UIAlertView showAlertWithTitle:@"Something Wrong" message:@"Please try again later!"];
  sender.selected = !currentCellProduct.likedValue;
  currentCellProduct.likedValue = !currentCellProduct.likedValue;
  
  if (flag) {
    currentCellProduct.likesValue++;
    label.text = [@(label.text.integerValue + 1) stringValue];
    return;
  }
  
  currentCellProduct.likesValue--;
  label.text = [@(label.text.integerValue - 1) stringValue];
}

- (void)hidePlaceHolder{
  [self.labelAnimated stopAnimating];
  [self.labelAnimated fadeOutWithDuration:0.4];
  self.imageViewProductPlaceholder.hidden = YES;
}

- (void)fullScreenScrollDidLayoutUIBars:(YIFullScreenScroll *)fullScreenScroll{
  CGRect newFrame = self.tableView.frame;
  newFrame.origin.y = fullScreenScroll.navigationBarHeight;
  self.tableView.frame = newFrame;
}

@end
