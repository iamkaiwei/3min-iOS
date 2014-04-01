//
//  TMELikedViewController.m
//  PhotoButton
//
//  Created by Toan Slan on 2/17/14.
//
//

#import "TMELikedViewController.h"
#import "TMELikedTableViewCell.h"

@interface TMELikedViewController ()

@property (strong, nonatomic) TMEBaseArrayDataSourceWithLoadMore *likedProductArrayDataSource;

@end

@implementation TMELikedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Stuff I Liked", nil);
    [self enablePullToRefresh];
    [self paddingScrollWithTop];
    
    [self getCachedLikedProduct];
    [self.pullToRefreshView beginRefreshing];
    [self loadLikedProductWithPage:1];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setEdgeForExtendedLayoutTop];
}

- (void)registerNibForTableView{
    self.arrayCellIdentifier = @[[TMELikedTableViewCell kind]];
    self.registerLoadMoreCell = YES;
}

- (void)setUpTableView{
    LoadMoreCellHandleBlock handleCell = ^(){
        [self loadLikedProductWithPage:++self.currentPage];
    };
    
    self.likedProductArrayDataSource = [[TMEBaseArrayDataSourceWithLoadMore alloc] initWithItems:self.dataArray cellIdentifier:[TMELikedTableViewCell kind] paging:self.paging handleCellBlock:handleCell];
    
    self.tableView.dataSource = self.likedProductArrayDataSource;
    [self refreshTableViewAnimated:NO];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TMEProductDetailsViewController *productDetailsController = [[TMEProductDetailsViewController alloc] init];
    productDetailsController.product = self.dataArray[indexPath.row];
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
    NSArray *arrayProductCached = [TMEProduct MR_findByAttribute:@"liked" withValue:@1 andOrderBy:@"created_at" ascending:NO];
    
    for (TMEProduct *product in arrayProductCached) {
        [self.dataArray addObject:product];
    }
    
    if (self.dataArray.count) {
        [self reloadTableViewLikedProduct];
    }
}

- (void)loadLikedProductWithPage:(NSInteger)page{
    if (![self isReachable]) {
        return;
    }
    
    [TMEProductsManager getLikedProductOnPage:page
                                 successBlock:^(NSArray *arrayProduct)
     {
         [self handlePagingWithResponseArray:arrayProduct currentPage:page];
         [self.dataArray addObjectsFromArray:arrayProduct];
         self.dataArray = [[self.dataArray sortByAttribute:@"created_at" ascending:NO] mutableCopy];
         [self reloadTableViewLikedProduct];
     }
                                 failureBlock:^(NSInteger statusCode, NSError *error)
     {
         [self failureBlockHandleWithError:error];
         [self finishLoading];
     }];
}

- (void)reloadTableViewLikedProduct{
    [self setUpTableView];
    [self finishLoading];
}

- (void)pullToRefreshViewDidStartLoading
{
    if (![self isReachable]) {
        return;
    }
    [self loadLikedProductWithPage:1];
}

@end
