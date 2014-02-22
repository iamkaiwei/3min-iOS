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

@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) TMEBaseArrayDataSourceWithLoadMore *likedProductArrayDataSource;

@end

@implementation TMELikedViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.title = @"Stuff I Liked";
  self.scrollableView = self.tableView;
  [self enablePullToRefresh];
  [self disableNavigationTranslucent];
  [self getCachedLikedProduct];
  
  if (!self.dataArray.count) {
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
  
  self.likedProductArrayDataSource = [[TMEBaseArrayDataSourceWithLoadMore alloc] initWithItems:self.dataArray cellIdentifier:kLikedTableViewCellIdentifier paging:self.paging handleCellBlock:handleCell];
  
  self.tableView.dataSource = self.likedProductArrayDataSource;
  [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

  TMEProductDetailsViewController *productDetailsController = [[TMEProductDetailsViewController alloc] init];
  NSInteger row = indexPath.row;
  productDetailsController.product = self.dataArray[row];
  productDetailsController.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:productDetailsController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  if (self.paging && indexPath.row == self.dataArray.count) {
    return [TMELoadMoreTableViewCell getHeight];
  }
  return [TMELikedTableViewCell getHeight];
}

- (void)getCachedLikedProduct{
  NSArray *arrayProductCached = [TMEProduct MR_findByAttribute:@"liked" withValue:@"1" andOrderBy:@"created_at" ascending:NO];
  
  for (TMEProduct *product in arrayProductCached) {
    [self.dataArray addObject:product];
  }
  
  self.currentPage = 0;
  if (self.dataArray.count) {
    self.currentPage = (self.dataArray.count / 10) + 1;
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
     
     NSMutableSet *setProduct = [NSMutableSet setWithArray:self.dataArray];
     [setProduct addObjectsFromArray:arrayProduct];
     self.dataArray = [[setProduct allObjects] mutableCopy];
     self.dataArray = [[self.dataArray sortByAttribute:@"created_at" ascending:NO] mutableCopy];
     
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
  [self refreshTableViewAnimated:NO];
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
