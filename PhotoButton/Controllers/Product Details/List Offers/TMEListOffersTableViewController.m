//
//  TMEListOffersTableViewController.m
//  PhotoButton
//
//  Created by Toan Slan on 3/3/14.
//
//

#import "TMEListOffersTableViewController.h"
#import "TMEListOffersTableViewCell.h"

@interface TMEListOffersTableViewController ()

@property (strong, nonatomic) TMEBaseArrayDataSource * listOffersArrayDataSource;

@end

@implementation TMEListOffersTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self enablePullToRefresh];
    self.title = @"List Offers";
    
    [self.pullToRefreshView beginRefreshing];
    [self loadListOffer];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setEdgeForExtendedLayoutTop];
}

- (void)registerNibForTableView{
    self.arrayCellIdentifier = @[[TMEListOffersTableViewCell kind]];
}

- (void)setUpTableView{
    self.listOffersArrayDataSource = [[TMEBaseArrayDataSource alloc] initWithItems:self.dataArray cellIdentifier:[TMEListOffersTableViewCell kind] delegate:nil];
    
    self.tableView.dataSource = self.listOffersArrayDataSource;
    [self refreshTableViewAnimated:NO];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TMESubmitViewController *submitViewController = [[TMESubmitViewController alloc] init];
    TMEConversation *conversation = self.dataArray[indexPath.row];
    submitViewController.product = conversation.product;
    submitViewController.conversation = conversation;
    
    [self.navigationController pushViewController:submitViewController animated:YES];
}

- (void)loadListOffer{
    if (![self isReachable]) {
        return;
    }
    [TMEConversationManager getListOffersOfProduct:self.product
                                    onSuccessBlock:^(NSArray *arrayConversation)
    {
        self.dataArray = [arrayConversation mutableCopy];
        [self reloadTableViewListOffer];
    }
                                      failureBlock:^(NSInteger statusCode, NSError *error)
     {
         [self failureBlockHandleWithError:error];
         [self finishLoading];
     }];
}

- (void)reloadTableViewListOffer{
    [self setUpTableView];
    [self finishLoading];
}

- (void)pullToRefreshViewDidStartLoading
{
    if (![self isReachable]) {
        return;
    }
    
    [self loadListOffer];
}

@end
