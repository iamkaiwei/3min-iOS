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

static NSString * const kMyListingTableViewCellIdentifier = @"TMEMyListingTableViewCell";

@interface TMEMyListingViewController ()

@property (strong, nonatomic) NSMutableArray *arrayProduct;
@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) TMEBaseArrayDataSourceWithLoadMore *myListingsArrayDataSource;

@end

@implementation TMEMyListingViewController

- (NSMutableArray *)arrayProduct{
  if (!_arrayProduct) {
    _arrayProduct = [[NSMutableArray alloc] init];
  }
  return _arrayProduct;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.title = @"My Listings";
  self.scrollableView = self.tableView;
  [self enablePullToRefresh];
  [self disableNavigationTranslucent];
  [self getCachedMyListing];
  
  if (!self.arrayProduct.count) {
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeGradient];
  }
  
  [self loadMyListWithPage:1];
}

- (void)registerNibForTableView{
  self.arrayCellIdentifier = @[kMyListingTableViewCellIdentifier];
  self.registerLoadMoreCell = YES;
}

- (void)setUpTableView{
  LoadMoreCellHandleBlock handleCell = ^(){
    [self loadMyListWithPage:self.currentPage++];
  };
  
  self.myListingsArrayDataSource = [[TMEBaseArrayDataSourceWithLoadMore alloc] initWithItems:self.arrayProduct cellIdentifier:kMyListingTableViewCellIdentifier paging:self.paging handleCellBlock:handleCell];
  
  self.tableView.dataSource = self.myListingsArrayDataSource;
  [self.tableView reloadData];
}

#pragma mark - UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  if (self.paging && indexPath.row == self.arrayProduct.count) {
    return [TMELoadMoreTableViewCell getHeight];
  }
  return [TMEMyListingTableViewCell getHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  TMEProductDetailsViewController *productDetailsController = [[TMEProductDetailsViewController alloc] init];
  productDetailsController.product = self.arrayProduct[indexPath.row];
  productDetailsController.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:productDetailsController animated:YES];
}

- (void)getCachedMyListing{
  NSArray *arrayProductCached = [TMEProduct MR_findByAttribute:@"user" withValue:[[TMEUserManager sharedInstance] loggedUser] andOrderBy:@"created_at" ascending:NO];
  
  for (TMEProduct *product in arrayProductCached) {
    [self.arrayProduct addObject:product];
  }
  self.currentPage = 0;
  if (self.arrayProduct.count) {
    self.currentPage = (self.arrayProduct.count / 10) + 1;
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
    
    NSMutableSet *setProduct = [NSMutableSet setWithArray:self.arrayProduct];
    [setProduct addObjectsFromArray:arrayProduct];
    
    self.arrayProduct = [[setProduct allObjects] mutableCopy];
    self.arrayProduct = [[self.arrayProduct sortByAttribute:@"created_at" ascending:NO] mutableCopy];
    
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
    [self reloadTableViewMyListing];
    [self.pullToRefreshView endRefreshing];
    return;
  }
  self.pullToRefreshView.attributedTitle = [[NSAttributedString alloc]initWithString:@"Refreshing activities.."];
  
  [self loadMyListWithPage:1];
  self.pullToRefreshView.attributedTitle = [[NSAttributedString alloc]initWithString:[NSString getLastestUpdateString]];
}


@end
