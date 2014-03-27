//
//  TMEMyListingViewController.m
//  PhotoButton
//
//  Created by Toan Slan on 2/12/14.
//
//

#import "TMEMyListingViewController.h"
#import "TMEMyListingTableViewCell.h"

@interface TMEMyListingViewController ()

@property (strong, nonatomic) TMEBaseArrayDataSourceWithLoadMore *myListingsArrayDataSource;

@end

@implementation TMEMyListingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"My Listings", nil);
    [self enablePullToRefresh];
    [self paddingScrollWithTop];
    
    [self getCachedMyListing];
    [self.pullToRefreshView beginRefreshing];
    [self loadMyListWithPage:1];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setEdgeForExtendedLayoutTop];
}

- (void)registerNibForTableView{
    self.arrayCellIdentifier = @[[TMEMyListingTableViewCell kind]];
    self.registerLoadMoreCell = YES;
}

- (void)setUpTableView{
    LoadMoreCellHandleBlock handleCell = ^(){
        [self loadMyListWithPage:++self.currentPage];
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
    
    if (self.dataArray.count) {
        [self reloadTableViewMyListing];
    }
}

- (void)loadMyListWithPage:(NSInteger)page{
    if (![self isReachable]) {
        return;
    }
    
    [TMEProductsManager getSellingProductsOfCurrentUserOnPage:page
                                                 successBlock:^(NSArray *arrayProduct)
     {
         [self handlePagingWithResponseArray:arrayProduct currentPage:page];
         [self.dataArray addObjectsFromArray:arrayProduct];
         [self reloadTableViewMyListing];
     }
                                                 failureBlock:^(NSInteger statusCode, NSError *error)
     {
         [self failureBlockHandleWithError:error];
         [self finishLoading];
     }];
}

- (void)reloadTableViewMyListing{
    [self setUpTableView];
    [self finishLoading];
}

- (void)pullToRefreshViewDidStartLoading
{
    if (![self isReachable]) {
        return;
    }
    [self loadMyListWithPage:1];
}


@end
