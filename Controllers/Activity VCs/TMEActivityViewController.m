//
//  TMEActivityViewController.m
//  PhotoButton
//
//  Created by admin on 1/2/14.
//
//

#import "TMEActivityViewController.h"
#import "TMEActivityTableViewCell.h"
#import "TMESubmitViewController.h"
#import "TMELoadMoreTableViewCell.h"
#import "TMEBaseArrayDataSourceWithLoadMore.h"

static NSString * const kActivityTableViewCellIdentifier = @"TMEActivityTableViewCell";

@interface TMEActivityViewController ()
<
UITableViewDelegate
>

@property (assign, nonatomic) NSInteger                               currentPage;
@property (strong, nonatomic) TMEBaseArrayDataSourceWithLoadMore *activitiesArrayDataSource;
@end

@implementation TMEActivityViewController

#pragma mark - VC cycle life

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.navigationController.navigationBar.topItem.title = @"Activity";
  self.scrollableView = self.tableView;
  [self.lblInstruction alignVerticallyCenterToView:self.view];
  [self enablePullToRefresh];
  [self disableNavigationTranslucent];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(reloadActivity:)
                                               name:NOTIFICATION_RELOAD_CONVERSATION
                                             object:nil];
  
  [self getCachedActivity];
  
  if (!self.dataArray.count) {
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeGradient];
  }
  
  [self loadListActivityWithPage:1];
}

- (void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  [self.tabBarController.tabBar.selectedItem setBadgeValue:nil];
  [self loadListActivityWithPage:1];
}

- (void)setUpTableView{
  LoadMoreCellHandleBlock handleCell = ^(){
    [self loadListActivityWithPage:self.currentPage++];
  };
  
  self.activitiesArrayDataSource = [[TMEBaseArrayDataSourceWithLoadMore alloc] initWithItems:self.dataArray cellIdentifier:kActivityTableViewCellIdentifier paging:self.paging handleCellBlock:handleCell];
                                    
  self.tableView.dataSource = self.activitiesArrayDataSource;
   [self.tableView reloadData];
}

- (void)registerNibForTableView{
  self.arrayCellIdentifier = @[kActivityTableViewCellIdentifier];
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
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
  [[TMEConversationManager sharedInstance] getListConversationWithPage:page
                                                        onSuccessBlock:^(NSArray *arrayConversation)
   {
     self.paging = YES;
     
     if (!arrayConversation.count) {
       self.paging = NO;
     }
     
     if (!self.currentPage) {
       self.currentPage = page;
     }
     NSMutableSet *setConversation = [NSMutableSet setWithArray:self.dataArray];
     [setConversation addObjectsFromArray:arrayConversation];
     
     self.dataArray = [[setConversation allObjects] mutableCopy];
     self.dataArray = [[self.dataArray sortByAttribute:@"latest_update" ascending:NO] mutableCopy];
     
     [self reloadTableViewActivity];
   }
                                                       andFailureBlock:^(NSInteger statusCode, NSError *error)
   {
     return DLog(@"%d", statusCode);
     [self.pullToRefreshView endRefreshing];
   }];
}

- (void)reloadActivity:(NSNotification *)notification{
  [self loadListActivityWithPage:1];
}

- (void)reloadTableViewActivity{
  [self setUpTableView];
  [self refreshTableViewAnimated:NO];
  [self.pullToRefreshView endRefreshing];
  [SVProgressHUD dismiss];
}

- (void)pullToRefreshViewDidStartLoading:(UIRefreshControl *)view
{
  if (![TMEReachabilityManager isReachable]) {
    [SVProgressHUD showErrorWithStatus:@"No connection!"];
    [self reloadTableViewActivity];
    [self.pullToRefreshView endRefreshing];
    return;
  }
  self.pullToRefreshView.attributedTitle = [[NSAttributedString alloc]initWithString:@"Refreshing activities.."];
  
  [self loadListActivityWithPage:1];
  self.pullToRefreshView.attributedTitle = [[NSAttributedString alloc]initWithString:[NSString getLastestUpdateString]];
}

@end
