//
//  TMEBrowerProductsViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "TMEBrowserProductsViewController.h"
#import "TMEBrowserProductsTableCell.h"
#import "TMESubmitViewController.h"

@interface TMEBrowserProductsViewController ()
<
UIScrollViewDelegate,
TMEBrowserProductsTableCellDelegate,
SSPullToRefreshViewDelegate
>

@property (weak, nonatomic) IBOutlet UITableView        * tableProducts;
@property (strong, nonatomic) NSMutableArray            * arrProducts;
@property (strong, nonatomic) TMEUser                   * loginUser;
@property (strong, nonatomic) TMECategory               * currentCategory;
@property (strong, nonatomic) SSPullToRefreshView       * pullToRefreshView;

@end

@implementation TMEBrowserProductsViewController

- (NSMutableArray *)arrProducts{
  if (_arrProducts) {
    return _arrProducts;
  }
  
  return [@[] mutableCopy];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  self.title = @"";
  self.navigationController.navigationBar.topItem.title = @"Broswer Products";
  [self paddingScrollWithTop];
  
  NSString *reuseCellsIndentifier = NSStringFromClass([TMEBrowserProductsTableCell class]);
  [self.tableProducts registerNib:[UINib nibWithNibName:reuseCellsIndentifier bundle:nil] forCellReuseIdentifier:reuseCellsIndentifier];
  
  self.pullToRefreshView = [[SSPullToRefreshView alloc] initWithScrollView:self.tableProducts delegate:self];
  
  [self.pullToRefreshView startLoading];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCategoryChangeNotification:) name:CATEGORY_CHANGE_NOTIFICATION object:nil];
  
}

#pragma marks - UITableView delegate

#pragma marks - UITableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.arrProducts.count;
}

- (TMEBrowserProductsTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIndentifier = NSStringFromClass([TMEBrowserProductsTableCell class]);
  TMEBrowserProductsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
  
  TMEProduct *product = [self.arrProducts objectAtIndex:indexPath.row];
  [cell configCellWithProduct:product];
    cell.delegate = self;
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return [TMEBrowserProductsTableCell getHeight];
}

- (void)loadProducts {
  if (self.currentCategory) {
    [[TMEProductsManager sharedInstance] getProductsOfCategory:self.currentCategory
                                                onSuccessBlock:^(NSArray *arrProducts) {
                                                  self.arrProducts = [arrProducts mutableCopy];
                                                  [self.tableProducts reloadData];
                                                  [self.pullToRefreshView finishLoading];
                                                  [SVProgressHUD dismiss];
                                                } andFailureBlock:^(NSInteger statusCode, id obj) {
                                                  [self.pullToRefreshView finishLoading];
                                                  [SVProgressHUD dismiss];
                                                }];
  } else {
    [[TMEProductsManager sharedInstance] getAllProductsOnSuccessBlock:^(NSArray *arrProducts) {
      self.arrProducts = [arrProducts mutableCopy];
      [self.tableProducts reloadData];
      [SVProgressHUD dismiss];
      
      [self.pullToRefreshView finishLoading];
    } andFailureBlock:^(NSInteger statusCode, id obj) {
      [self.pullToRefreshView finishLoading];
      [SVProgressHUD dismiss];
    }];
  }
}

#pragma mark - Table cell delegate

- (void)onBtnComment{
    [self.navigationController pushViewController:[[TMESubmitViewController alloc] init] animated:YES];
}

#pragma mark - SSPullToRefreshView delegate
- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view
{
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeGradient];
    [self loadProducts];
}

#pragma mark - Utilities
- (void)paddingScrollWithTop
{
  CGFloat scrollViewTopInset = 44;
  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
    scrollViewTopInset += 20;
  }
  self.tableProducts.contentInset = UIEdgeInsetsMake(scrollViewTopInset, 0, 0, 0);
}

#pragma mark - Notifications
- (void)onCategoryChangeNotification:(NSNotification *)notification
{
  NSDictionary *userInfo = [notification userInfo];
  self.currentCategory = [userInfo objectForKey:@"category"];
  [self loadProducts];
}
@end
