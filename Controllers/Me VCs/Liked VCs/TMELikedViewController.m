//
//  TMELikedViewController.m
//  PhotoButton
//
//  Created by Toan Slan on 2/17/14.
//
//

#import "TMELikedViewController.h"
#import "TMEBaseArrayDataSourceWithLoadMore.h"
#import "TMELoadMoreTableViewCell.h"
#import "TMELikedTableViewCell.h"
#import "TMEProductDetailsViewController.h"

static NSString * const kLikedTableViewCellIdentifier = @"TMELikedTableViewCell";

@interface TMELikedViewController ()

@property (strong, nonatomic) NSMutableArray *arrayProduct;
@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) TMEBaseArrayDataSourceWithLoadMore *likedProductArrayDataSource;

@end

@implementation TMELikedViewController

- (NSMutableArray *)arrayProduct{
  if (!_arrayProduct) {
    _arrayProduct = [[NSMutableArray alloc] init];
  }
  return _arrayProduct;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.title = @"Stuff I Liked";
  self.scrollableView = self.tableView;
  [self enablePullToRefresh];
  [self disableNavigationTranslucent];
  [self getCachedLikedProduct];
  
  if (!self.arrayProduct.count) {
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeGradient];
  }
  
  [self loadLikedProductWithPage:1];
}

- (void)registerNibForTableView{
  self.arrayCellIdentifier = @[kLikedTableViewCellIdentifier];
  self.registerLoadMoreCell = YES;
}

- (void)setUpTableView{
  LoadMoreCellHandleBlock handleCell = ^(){
    [self loadLikedProductWithPage:self.currentPage++];
  };
  
  self.likedProductArrayDataSource = [[TMEBaseArrayDataSourceWithLoadMore alloc] initWithItems:self.arrayProduct cellIdentifier:kLikedTableViewCellIdentifier paging:self.paging handleCellBlock:handleCell];
  
  self.tableView.dataSource = self.likedProductArrayDataSource;
  [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

  TMEProductDetailsViewController *productDetailsController = [[TMEProductDetailsViewController alloc] init];
  NSInteger row = indexPath.row;
  productDetailsController.product = self.arrayProduct[row];
  productDetailsController.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:productDetailsController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  if (self.paging && indexPath.row == self.arrayProduct.count) {
    return [TMELoadMoreTableViewCell getHeight];
  }
  return [TMELikedTableViewCell getHeight];
}

- (void)getCachedLikedProduct{
  NSArray *arrayProductCached = [TMEProduct MR_findByAttribute:@"liked" withValue:@"1" andOrderBy:@"created_at" ascending:NO];
  
  for (TMEProduct *product in arrayProductCached) {
    [self.arrayProduct addObject:product];
  }
  
  self.currentPage = 0;
  if (self.arrayProduct.count) {
    self.currentPage = (self.arrayProduct.count / 10) + 1;
    [self reloadTableViewLikedProduct];
  }
}

- (void)loadLikedProductWithPage:(NSInteger)page{
  [[TMEProductsManager sharedInstance] getLikedProductOnPage:page
                                                     successBlock:^(NSArray *arrayProduct)
   {
     self.paging = YES;
     
     if (!arrayProduct.count){
       self.paging = NO;
     }
     
     if (!self.currentPage) {
       self.currentPage = page;
     }
     
     NSMutableSet *setProduct = [NSMutableSet setWithArray:self.arrayProduct];
     [setProduct addObjectsFromArray:arrayProduct];
     self.arrayProduct = [[setProduct allObjects] mutableCopy];
     self.arrayProduct = [[self.arrayProduct sortByAttribute:@"created_at" ascending:NO] mutableCopy];
     
     [self reloadTableViewLikedProduct];
   }
                                                failureBlock:^(NSInteger statusCode, NSError *error)
   {
     return DLog(@"%d", statusCode);
     [self.pullToRefreshView endRefreshing];
   }];
}

- (void)reloadTableViewLikedProduct{
  [self setUpTableView];
  if (self.arrayProduct.count) {
    self.tableView.hidden = NO;
  }
  [SVProgressHUD dismiss];
  [self.pullToRefreshView endRefreshing];
}

- (void)pullToRefreshViewDidStartLoading:(UIRefreshControl *)view
{
  if (![TMEReachabilityManager isReachable]) {
    [SVProgressHUD showErrorWithStatus:@"No connection!"];
    [self reloadTableViewLikedProduct];
    [self.pullToRefreshView endRefreshing];
    return;
  }
  self.pullToRefreshView.attributedTitle = [[NSAttributedString alloc]initWithString:@"Refreshing activities.."];
  
  [self loadLikedProductWithPage:1];
  self.pullToRefreshView.attributedTitle = [[NSAttributedString alloc]initWithString:[NSString getLastestUpdateString]];
}

@end
