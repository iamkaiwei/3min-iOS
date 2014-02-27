//
//  TMEActivityViewController.m
//  PhotoButton
//
//  Created by admin on 1/2/14.
//
//

#import "TMEActivityViewController.h"
#import "TMEActivityTableViewCell.h"

@interface TMEActivityViewController ()

@property (strong, nonatomic) TMEBaseArrayDataSourceWithLoadMore    * activitiesArrayDataSource;
@end

@implementation TMEActivityViewController

#pragma mark - VC cycle life

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.title = @"Activity";
    // remember to avoid retain cycles!
    [self enablePullToRefresh];
    [self disableBottomTranslucent];
    [self paddingScrollWithTop];
    [self.lblInstruction alignVerticallyCenterToView:self.view];
    
    [self getCachedActivity];
    [self.pullToRefreshView beginRefreshing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadActivity:)
                                                 name:NOTIFICATION_RELOAD_CONVERSATION
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar.selectedItem setBadgeValue:nil];
    [self loadListActivityWithPage:1];
}

- (void)setUpTableView{
    LoadMoreCellHandleBlock handleCell = ^(){
        [self loadListActivityWithPage:++self.currentPage];
    };
    
    self.activitiesArrayDataSource = [[TMEBaseArrayDataSourceWithLoadMore alloc] initWithItems:self.dataArray cellIdentifier:[TMEActivityTableViewCell kind] paging:self.paging handleCellBlock:handleCell];
    
    self.tableView.dataSource = self.activitiesArrayDataSource;
    [self refreshTableViewAnimated:NO];
}

- (void)registerNibForTableView{
    self.arrayCellIdentifier = @[[TMEActivityTableViewCell kind]];
    self.registerLoadMoreCell = YES;
}

#pragma mark - UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.paging && indexPath.row == self.dataArray.count) {
        return [TMELoadMoreTableViewCell getHeight];
    }
    return [TMEActivityTableViewCell getHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TMESubmitViewController *submitController = [[TMESubmitViewController alloc] init];
    
    TMEConversation *conversation = self.dataArray[indexPath.row];
    
    submitController.product = conversation.product;
    submitController.conversation = conversation;
    
    [self.navigationController pushViewController:submitController animated:YES];
}

#pragma mark - Caching stuffs

- (void)getCachedActivity{
    NSArray *arrayActivityCached = [TMEConversation MR_findAllSortedBy:@"latest_update" ascending:NO];
    
    for (TMEConversation *conversation in arrayActivityCached) {
        [self.dataArray addObject:conversation];
    }
    self.currentPage = 0;
    if (self.dataArray.count) {
        self.currentPage = (self.dataArray.count / 10) + 1;
        [self reloadTableViewActivity];
    }
}

#pragma mark - Handle notification

- (void)loadListActivityWithPage:(NSInteger)page{
    if (![self isReachable]) {
        return;
    }
    
    [[TMEConversationManager sharedInstance] getListConversationWithPage:page
                                                          onSuccessBlock:^(NSArray *arrayConversation)
     {
         [self handlePagingWithResponseArray:arrayConversation currentPage:page];
         
         self.dataArray = [[self.dataArray arrayUniqueByAddingObjectsFromArray:arrayConversation] mutableCopy];
         self.dataArray = [[self.dataArray sortByAttribute:@"latest_update" ascending:NO] mutableCopy];
         
         [self reloadTableViewActivity];
     }
                                                         andFailureBlock:^(NSInteger statusCode, NSError *error)
     {
         [self finishLoading];
     }];
}

- (void)reloadActivity:(NSNotification *)notification{
    [self loadListActivityWithPage:1];
}

- (void)reloadTableViewActivity{
    [self setUpTableView];
    [self finishLoading];
}

- (void)pullToRefreshViewDidStartLoading
{
    if (![self isReachable]) {
        return;
    }
    
    [self loadListActivityWithPage:1];
}

@end
