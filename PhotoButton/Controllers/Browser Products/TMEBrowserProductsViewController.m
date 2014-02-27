//
//  TMEBrowerProductsViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "TMEBrowserProductsViewController.h"
#import "TMEBrowserProductsTableCell.h"
#import "TMEBrowserProductTableViewHeader.h"
#import "TMEBrowserProductsViewControllerArrayDataSource.h"

@interface TMEBrowserProductsViewController ()
<
UIScrollViewDelegate,
UITableViewDelegate,
TMEBrowserProductsTableCellDelegate
>

@property (assign, nonatomic) CGFloat                     currentNavBarHeight;
@property (strong, nonatomic) TMEUser                   * loginUser;
@property (strong, nonatomic) TMECategory               * currentCategory;
@property (strong, nonatomic) TMEBrowserProductsViewControllerArrayDataSource    * productsArrayDataSource;
@property (weak, nonatomic) IBOutlet UIImageView        * imageViewProductPlaceholder;
@property (weak, nonatomic) IBOutlet MTAnimatedLabel    * labelAnimated;
@end

@implementation TMEBrowserProductsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.labelAnimated startAnimating];
    self.navigationController.navigationBar.topItem.title = @"Browse Products";
    
    [self setUpCircleProgressIndicator];
    [self enablePullToRefresh];
    [self setUpTableView];
    [self paddingScrollWithTop];
    [self loadProductsWithPage:1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onCategoryChangeNotification:)
                                                 name:CATEGORY_CHANGE_NOTIFICATION
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUpTableView];
}

- (void)registerNibForTableView{
    [self.tableView registerNib:[TMEBrowserProductTableViewHeader defaultNib] forHeaderFooterViewReuseIdentifier:[TMEBrowserProductTableViewHeader kind]];
    
    self.arrayCellIdentifier = @[[TMEBrowserProductsTableCell kind]];
    self.registerLoadMoreCell = YES;
}

- (void)setUpCircleProgressIndicator{
    [[TMECircleProgressIndicator appearance] setStrokeProgressColor:[UIColor orangeMainColor]];
    [[TMECircleProgressIndicator appearance] setStrokeRemainingColor:[UIColor whiteColor]];
    [[TMECircleProgressIndicator appearance] setStrokeWidth:3.0f];
}

- (void)setUpTableView{
    LoadMoreCellHandleBlock handleLoadMoreCell = ^(){
        [self loadProductsWithPage:self.currentPage++];
    };
    
    self.productsArrayDataSource = [[TMEBrowserProductsViewControllerArrayDataSource alloc] initWithItems:self.dataArray cellIdentifier:[TMEBrowserProductsTableCell kind] paging:self.paging handleCellBlock:handleLoadMoreCell delegate:self];
    
    self.tableView.dataSource = self.productsArrayDataSource;
    [self refreshTableViewAnimated:NO];
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TMEProductDetailsViewController *productDetailsController = [[TMEProductDetailsViewController alloc] init];
    productDetailsController.product = self.dataArray[indexPath.section];
    productDetailsController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:productDetailsController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.paging && section == self.dataArray.count) {
        return 0;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.paging && indexPath.section == self.dataArray.count) {
        return [TMELoadMoreTableViewCell getHeight];
    }
    return [TMEBrowserProductsTableCell getHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TMEBrowserProductTableViewHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[TMEBrowserProductTableViewHeader kind]];
    [header configHeaderWithData:self.dataArray[section]];
    
    return header;
}

#pragma mark - Load Product

- (void)loadProductsWithPage:(NSInteger)page{
    if (![self isReachable]) {
        return;
    }
    
    if (self.currentCategory) {
        [[TMEProductsManager sharedInstance] getProductsOfCategory:self.currentCategory
                                                          withPage:page
                                                    onSuccessBlock:^(NSArray *arrProducts)
         {
             [self handlePagingWithResponseArray:arrProducts currentPage:page];
             [self hidePlaceHolder];
             
             self.dataArray = [[self.dataArray arrayUniqueByAddingObjectsFromArray:arrProducts] mutableCopy];
             self.dataArray = [[self.dataArray sortByAttribute:@"created_at" ascending:NO] mutableCopy];
             
             [self setUpTableView];
             [self finishLoading];
         } andFailureBlock:^(NSInteger statusCode, id obj) {
             [self finishLoading];
         }];
        return;
    }
    
    [[TMEProductsManager sharedInstance] getAllProductsWihPage:page
                                                onSuccessBlock:^(NSArray *arrProducts)
     {
         [self handlePagingWithResponseArray:arrProducts currentPage:page];
         [self hidePlaceHolder];
         
         self.dataArray = [[self.dataArray arrayUniqueByAddingObjectsFromArray:arrProducts] mutableCopy];
         self.dataArray = [[self.dataArray sortByAttribute:@"created_at" ascending:NO] mutableCopy];
         
         [self setUpTableView];
         [self finishLoading];
         
     } andFailureBlock:^(NSInteger statusCode, id obj) {
         [self finishLoading];
     }];
    
}


#pragma mark - SSPullToRefreshView delegate
- (void)pullToRefreshViewDidStartLoading
{
    if (![self isReachable]) {
        return;
    }
    
    [self loadProductsWithPage:1];
}

#pragma mark - Utilities
- (void)paddingScrollWithTop
{
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        CGFloat scrollViewTopInset = 44;
        self.tableView.contentInset = UIEdgeInsetsMake(scrollViewTopInset, 0, 0, 0);
    }
}

#pragma mark - Notifications
- (void)onCategoryChangeNotification:(NSNotification *)notification
{
    if (![self isReachable]) {
        return;
    }
    NSDictionary *userInfo = [notification userInfo];
    if ([self.currentCategory isEqual:[userInfo objectForKey:@"category"]]) {
        return;
    }
    
    self.currentCategory = [userInfo objectForKey:@"category"];
    self.navigationController.navigationBar.topItem.title = self.currentCategory.name;
    [self.tableView setContentOffset:CGPointMake(0, -60) animated:YES];
    [self.pullToRefreshView beginRefreshing];
    [self loadProductsWithPage:1];
}

#pragma mark - Button Like Action
- (void)onBtnLike:(UIButton *)sender label:(UILabel *)label{
    if (![self isReachable]) {
        return;
    }
    UITableViewCell *cell = [self getCellFromButton:sender];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    TMEProduct *currentCellProduct = self.dataArray[indexPath.row];
    sender.selected = !currentCellProduct.likedValue;
    
    if (!currentCellProduct.likedValue) {
        [[TMEProductsManager sharedInstance] likeProductWithProductID:currentCellProduct.id
                                                       onSuccessBlock:nil                                                  andFailureBlock:^(NSInteger statusCode, NSError *error)
        {
            [self likeProductFailureHandleButtonLike:sender currentCellProduct:currentCellProduct label:label unlike:NO];
        }];
        
        currentCellProduct.likedValue = YES;
        currentCellProduct.likesValue++;
        
        label.text = [@(label.text.integerValue + 1) stringValue];
        return;
    }
    
    [[TMEProductsManager sharedInstance] unlikeProductWithProductID:currentCellProduct.id
                                                     onSuccessBlock:nil                                                  andFailureBlock:^(NSInteger statusCode, NSError *error)
    {
        [self likeProductFailureHandleButtonLike:sender currentCellProduct:currentCellProduct label:label unlike:YES];
    }];
    
    currentCellProduct.likedValue = NO;
    currentCellProduct.likesValue--;
    label.text = [@(label.text.integerValue - 1) stringValue];
}

- (void)likeProductFailureHandleButtonLike:(UIButton *)sender currentCellProduct:(TMEProduct *)currentCellProduct label:(UILabel *)label unlike:(BOOL)flag{
    [UIAlertView showAlertWithTitle:@"Something Wrong" message:@"Please try again later!"];
    sender.selected = !currentCellProduct.likedValue;
    currentCellProduct.likedValue = !currentCellProduct.likedValue;
    
    if (flag) {
        currentCellProduct.likesValue++;
        label.text = [@(label.text.integerValue + 1) stringValue];
        return;
    }
    
    currentCellProduct.likesValue--;
    label.text = [@(label.text.integerValue - 1) stringValue];
}

- (UITableViewCell *)getCellFromButton:(UIButton *)sender{
    UIView *superView = sender.superview;
    
    while (nil != sender.superview) {
        if ([superView isKindOfClass:[UITableViewCell class]]) {
            break;
        }
        superView = superView.superview;
    }
    return (UITableViewCell *)superView;
}

- (void)hidePlaceHolder{
    [self.labelAnimated stopAnimating];
    [self.labelAnimated fadeOutWithDuration:0.4];
    self.imageViewProductPlaceholder.hidden = YES;
}

- (void)fullScreenScrollDidLayoutUIBars:(YIFullScreenScroll *)fullScreenScroll{
    if(self.currentNavBarHeight == fullScreenScroll.navigationBarHeight){
        return;
    }
    CGRect newFrame = self.tableView.frame;
    CGFloat navBarHeightForVersionCheck = fullScreenScroll.navigationBarHeight;
    if(SYSTEM_VERSION_LESS_THAN(@"7.0")){
        navBarHeightForVersionCheck = fullScreenScroll.navigationBarHeight + CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
    }
    
    newFrame.origin.y = navBarHeightForVersionCheck;
    newFrame.size.height = [[UIScreen mainScreen]bounds].size.height - navBarHeightForVersionCheck;
    
    self.tableView.frame = newFrame;
    self.tableView.height = CGRectGetHeight(newFrame);
    self.currentNavBarHeight = fullScreenScroll.navigationBarHeight;
}

@end
