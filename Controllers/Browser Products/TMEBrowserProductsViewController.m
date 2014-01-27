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

@interface TMEBrowserProductsViewController ()
<
UIScrollViewDelegate,
UITableViewDelegate,
TMEBrowserProductsTableCellDelegate
>

@property (weak, nonatomic) IBOutlet UITableView        * tableProducts;
@property (strong, nonatomic) NSMutableArray            * arrProducts;
@property (strong, nonatomic) TMEUser                   * loginUser;
@property (strong, nonatomic) TMECategory               * currentCategory;

@end

@implementation TMEBrowserProductsViewController

- (NSMutableArray *)arrProducts{
  if (_arrProducts) {
    return _arrProducts;
  }
  
  return [@[] mutableCopy];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  self.navigationController.navigationBar.topItem.title = @"Browse Products";
  
  [[XLCircleProgressIndicator appearance] setStrokeProgressColor:[UIColor orangeMainColor]];
  [[XLCircleProgressIndicator appearance] setStrokeRemainingColor:[UIColor whiteColor]];
  [[XLCircleProgressIndicator appearance] setStrokeWidth:3.0f];
  
  NSString *reuseCellsIndentifier = NSStringFromClass([TMEBrowserProductsTableCell class]);
  [self.tableProducts registerNib:[UINib nibWithNibName:reuseCellsIndentifier bundle:nil] forCellReuseIdentifier:reuseCellsIndentifier];
  self.scrollableView = self.tableProducts;
  [self enablePullToRefresh];
  [self loadProducts];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(onCategoryChangeNotification:)
                                               name:CATEGORY_CHANGE_NOTIFICATION
                                             object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  [self.tableProducts reloadData];
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  TMEProductDetailsViewController *productDetailsController = [[TMEProductDetailsViewController alloc] init];
  productDetailsController.product = self.arrProducts[indexPath.row];
  productDetailsController.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:productDetailsController animated:YES];
}

#pragma mark - UITableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.arrProducts.count;
}

- (TMEBrowserProductsTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIndentifier = NSStringFromClass([TMEBrowserProductsTableCell class]);
  TMEBrowserProductsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
  
  TMEProduct *product = [self.arrProducts objectAtIndex:indexPath.row];
  [cell configCellWithProduct:product];
  cell.delegate = self;
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return [TMEBrowserProductsTableCell getHeight];
}

- (void)loadProducts{
  if (![TMEReachabilityManager isReachable]) {
    [SVProgressHUD showErrorWithStatus:@"No connection!"];
    [self.pullToRefreshView endRefreshing];
    return;
  }
  [SVProgressHUD showWithStatus:@"Refreshing products..."];
  if (self.currentCategory) {
    [[TMEProductsManager sharedInstance] getProductsOfCategory:self.currentCategory
                                                onSuccessBlock:^(NSArray *arrProducts) {
                                                  self.arrProducts = [arrProducts mutableCopy];
                                                  [self.tableProducts reloadData];
                                                  [self.pullToRefreshView endRefreshing];
                                                  [SVProgressHUD dismiss];
                                                } andFailureBlock:^(NSInteger statusCode, id obj) {
                                                  [self.pullToRefreshView endRefreshing];
                                                  [SVProgressHUD dismiss];
                                                }];
  } else {
    [[TMEProductsManager sharedInstance] getAllProductsOnSuccessBlock:^(NSArray *arrProducts) {
      self.arrProducts = [arrProducts mutableCopy];
      [self.tableProducts reloadData];
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
  
  NSDateFormatter *formattedDate = [[NSDateFormatter alloc]init];
  [formattedDate setDateFormat:@"d MMM, h:mm a"];
  NSString *lastupdated = [NSString stringWithFormat:@"Last Updated on %@",[formattedDate stringFromDate:[NSDate date]]];
  self.pullToRefreshView.attributedTitle = [[NSAttributedString alloc]initWithString:lastupdated];
  [self loadProducts];
}

#pragma mark - Utilities
- (void)paddingScrollWithTop
{
  CGFloat scrollViewTopInset = 44;
  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
    scrollViewTopInset += 20;
  }
  self.tableProducts.contentInset = UIEdgeInsetsMake(scrollViewTopInset, 0, 0, 0);
}

#pragma mark - Notifications
- (void)onCategoryChangeNotification:(NSNotification *)notification
{
  NSDictionary *userInfo = [notification userInfo];
  self.currentCategory = [userInfo objectForKey:@"category"];
  [self loadProducts];
}

- (void)onBtnLike:(UIButton *)sender label:(UILabel *)label{
  UIView *superView = sender.superview;
  
  while (nil != sender.superview) {
    if ([superView isKindOfClass:[UITableViewCell class]]) {
      break;
    }
    superView = superView.superview;
  }
  
  NSIndexPath *indexPath = [self.tableProducts indexPathForCell:(UITableViewCell *)superView];
  TMEProduct *currentCellProduct = self.arrProducts[indexPath.row];
  sender.selected = !currentCellProduct.likedValue;
  
  if (!currentCellProduct.likedValue) {
    [[TMEProductsManager sharedInstance] likeProductWithProductID:currentCellProduct.id
                                                   onSuccessBlock:nil
                                                  andFailureBlock:nil];
    currentCellProduct.likedValue = YES;
    currentCellProduct.likesValue++;
    label.text = [@(label.text.integerValue + 1) stringValue];
    return;
  }
  
  [[TMEProductsManager sharedInstance] unlikeProductWithProductID:currentCellProduct.id
                                                   onSuccessBlock:nil
                                                  andFailureBlock:nil];
  currentCellProduct.likedValue = NO;
  currentCellProduct.likesValue--;
  label.text = [@(label.text.integerValue - 1) stringValue];
}

@end
