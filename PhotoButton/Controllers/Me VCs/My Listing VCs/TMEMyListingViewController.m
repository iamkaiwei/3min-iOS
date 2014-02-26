//
//  TMEMyListingViewController.m
//  PhotoButton
//
//  Created by Toan Slan on 2/12/14.
//
//

#import "TMEMyListingViewController.h"
#import "TMEMyListingTableViewCell.h"
#import "TMELoadMoreTableViewCell.h"
#import "TMEBaseArrayDataSourceWithLoadMore.h"
#import "TMEProductDetailsViewController.h"

@interface TMEMyListingViewController ()

@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) TMEBaseArrayDataSourceWithLoadMore *myListingsArrayDataSource;

@end

@implementation TMEMyListingViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.title = @"My Listings";
  [self enablePullToRefresh];
  [self disableNavigationTranslucent];
  [self getCachedMyListing];
  
  if (!self.dataArray.count) {
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeGradient];
  }
  
  [self loadMyListWithPage:1];
}

- (void)registerNibForTableView{
  self.arrayCellIdentifier = @[[TMEMyListingTableViewCell kind]];
  self.registerLoadMoreCell = YES;
}

- (void)setUpTableView{
  LoadMoreCellHandleBlock handleCell = ^(){
    [self loadMyListWithPage:self.currentPage++];
  };
  
  self.myListingsArrayDataSource = [[TMEBaseArrayDataSourceWithLoadMore alloc] initWithItems:self.dataArray cellIdentifier:[TMEMyListingTableViewCell kind] paging:self.paging handleCellBlock:handleCell];
  
  self.tableView.dataSource = self.myListingsArrayDataSource;
  [self refreshTableViewAnimated:NO];
}

#pragma mark - UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  if (self.paging && indexPath.row == self.dataArray.count) {
    return [TMELoadMoreTableViewCell getHeight];
  }
  return [TMEMyListingTableViewCell getHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  TMEProductDetailsViewController *productDetailsController = [[TMEProductDetailsViewController alloc] init];
  productDetailsController.product = self.dataArray[indexPath.row];
  productDetailsController.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:productDetailsController animated:YES];
}

- (void)getCachedMyListing{
  NSArray *arrayProductCached = [TMEProduct MR_findByAttribute:@"user" withValue:[[TMEUserManager sharedInstance] loggedUser] andOrderBy:@"created_at" ascending:NO];
  
  for (TMEProduct *product in arrayProductCached) {
    if (product.created_at) {
      [self.dataArray addObject:product];
    }
  }
  
  self.currentPage = 0;
  if (self.dataArray.count) {
    self.currentPage = (self.dataArray.count / 10) + 1;
    [self reloadTableViewMyListing];
  }
}

- (void)loadMyListWithPage:(NSInteger)page{
  [[TMEProductsManager sharedInstance] getSellingProductsOfCurrentUserOnPage:page
                                                                successBlock:^(NSArray *arrayProduct)
  {
    self.paging = YES;
    
    if (!arrayProduct.count) {
      self.paging = NO;
    }
    
    if (!self.currentPage) {
      self.currentPage = page;
    }
    
    NSMutableSet *setProduct = [NSMutableSet setWithArray:self.dataArray];
    [setProduct addObjectsFromArray:arrayProduct];
    
    self.dataArray = [[setProduct allObjects] mutableCopy];
    self.dataArray = [[self.dataArray sortByAttribute:@"created_at" ascending:NO] mutableCopy];
    
    [self reloadTableViewMyListing];
  }
                                                                failureBlock:^(NSInteger statusCode, NSError *error)
  {
    return DLog(@"%d", statusCode);
    [self.pullToRefreshView endRefreshing];
  }];
}

- (void)reloadTableViewMyListing{
  [self setUpTableView];
  [SVProgressHUD dismiss];
  [self.pullToRefreshView endRefreshing];
}

- (void)pullToRefreshViewDidStartLoading
{
  if (![TMEReachabilityManager isReachable]) {
    [SVProgressHUD showErrorWithStatus:@"No connection!"];
    [self reloadTableViewMyListing];
    [self.pullToRefreshView endRefreshing];
    return;
  }
  [self loadMyListWithPage:1];
}


@end
