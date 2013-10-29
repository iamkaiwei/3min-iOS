//
//  TMEBrowerProductsViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "TMEBrowserProductsViewController.h"
#import "TMEBrowserProductsTableCell.h"

@interface TMEBrowserProductsViewController ()
<
UIScrollViewDelegate,
SSPullToRefreshViewDelegate
>

@property (weak, nonatomic) IBOutlet UITableView        * tableProducts;
@property (strong, nonatomic) NSMutableArray            * arrProducts;
@property (strong, nonatomic) TMEUser                   * loginUser;

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
    
    [self loadProductsTable];
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
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TMEBrowserProductsTableCell getHeight];
}

- (void)loadProductsTable{
    
    [self.pullToRefreshView startLoading];
    
    [[TMEProductsManager sharedInstance] getAllProductsOnSuccessBlock:^(NSArray *arrProducts) {
        
        self.arrProducts = [arrProducts mutableCopy];
        [self.tableProducts reloadData];
        
        [self.pullToRefreshView finishLoading];
        
    } andFailureBlock:^(NSInteger statusCode, id obj) {
        [self.pullToRefreshView finishLoading];
    }];
}

#pragma mark - SSPullToRefreshView delegate
- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view
{
    [self loadProductsTable];
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

@end
