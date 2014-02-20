//
//  TMEOfferedViewController.m
//  PhotoButton
//
//  Created by Toan Slan on 2/13/14.
//
//

#import "TMEOfferedViewController.h"
#import "TMEOfferedTableViewCell.h"
#import "TMEBaseArrayDataSourceWithLoadMore.h"
#import "TMELoadMoreTableViewCell.h"
#import "TMESubmitViewController.h"

static NSString * const KOfferedTableVIewCellIdentifier = @"TMEOfferedTableViewCell";

@interface TMEOfferedViewController()

@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) TMEBaseArrayDataSourceWithLoadMore * offeredConversationArrayDataSource;

@end

@implementation TMEOfferedViewController

#pragma mark - VC cycle life

- (void)viewDidLoad{
  [super viewDidLoad];
  self.title = @"Offer I Made";
  self.scrollableView = self.tableView;
  [self enablePullToRefresh];
  [self disableNavigationTranslucent];
  
  [self getCachedOfferedConversation];
  
  if (!self.dataArray.count) {
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeGradient];
  }
  
  [self loadListOfferedConversationWithPage:1];
}

- (void)setUpTableView{
  LoadMoreCellHandleBlock handleCell = ^(){
    [self loadListOfferedConversationWithPage:self.currentPage++];
  };
  
  self.offeredConversationArrayDataSource = [[TMEBaseArrayDataSourceWithLoadMore alloc] initWithItems:self.dataArray cellIdentifier:KOfferedTableVIewCellIdentifier paging:self.paging handleCellBlock:handleCell];
  
  self.tableView.dataSource = self.offeredConversationArrayDataSource;
  [self.tableView reloadData];
}

- (void)registerNibForTableView{
  self.arrayCellIdentifier = @[KOfferedTableVIewCellIdentifier];
  self.registerLoadMoreCell = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  if (self.paging && indexPath.row == self.dataArray.count) {
    return [TMELoadMoreTableViewCell getHeight];
  }
  return [TMEOfferedTableViewCell getHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  TMESubmitViewController *submitController = [[TMESubmitViewController alloc] init];
  
  TMEConversation *conversation = self.dataArray[indexPath.row];
  
  submitController.product = conversation.product;
  submitController.conversation = conversation;
  

  [self.navigationController pushViewController:submitController animated:YES];
}

- (void)loadListOfferedConversationWithPage:(NSInteger)page{
  [[TMEConversationManager sharedInstance] getOfferedConversationWithPage:page
                                                           onSuccessBlock:^(NSArray *arrayOfferedConversation)
   {
     self.paging = YES;
     
     if (!arrayOfferedConversation.count) {
       self.paging = NO;
     }
     
     if (!self.currentPage) {
       self.currentPage = page;
     }
     
     NSMutableSet *setConversation = [NSMutableSet setWithArray:self.dataArray];
     [setConversation addObjectsFromArray:arrayOfferedConversation];
     
     self.dataArray = [[setConversation allObjects] mutableCopy];
     self.dataArray = [[self.dataArray sortByAttribute:@"latest_update" ascending:NO] mutableCopy];
     
     [self reloadTableViewOfferedConversation];
   }
                                                          andFailureBlock:^(NSInteger statusCode, NSError *error)
   {
     return DLog(@"%d", statusCode);
     [self.pullToRefreshView endRefreshing];
   }];
}

- (void)getCachedOfferedConversation{
  NSArray *arrayOfferedConversationCached = [TMEConversation MR_findAllSortedBy:@"latest_update" ascending:NO];
  
  for (TMEConversation *conversation in arrayOfferedConversationCached) {
    if (![conversation.offer isEqualToNumber:@0] && ![conversation.offer isEqual:[NSNull null]]) {
      [self.dataArray addObject:conversation];
    }
  }
  self.currentPage = 0;
  if (self.dataArray.count) {
    self.currentPage = (self.dataArray.count / 10) + 1;
    [self reloadTableViewOfferedConversation];
  }
}

- (void)reloadTableViewOfferedConversation{
  [self setUpTableView];
  [self refreshTableViewAnimated:NO];
  [self.pullToRefreshView endRefreshing];
  [SVProgressHUD dismiss];
}

- (void)pullToRefreshViewDidStartLoading:(UIRefreshControl *)view
{
  if (![TMEReachabilityManager isReachable]) {
    [SVProgressHUD showErrorWithStatus:@"No connection!"];
    [self reloadTableViewOfferedConversation];
    [self.pullToRefreshView endRefreshing];
    return;
  }
  self.pullToRefreshView.attributedTitle = [[NSAttributedString alloc]initWithString:@"Refreshing activities.."];
  
  [self loadListOfferedConversationWithPage:1];
  self.pullToRefreshView.attributedTitle = [[NSAttributedString alloc]initWithString:[NSString getLastestUpdateString]];
}


@end
