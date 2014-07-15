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
TMEBrowserProductsTableCellDelegate
>

@property (assign, nonatomic) CGFloat                     currentNavBarHeight;
@property (strong, nonatomic) TMEBrowserProductsViewControllerArrayDataSource    * productsArrayDataSource;
@property (weak, nonatomic) IBOutlet UIImageView        * imageViewProductPlaceholder;
@property (weak, nonatomic) IBOutlet MTAnimatedLabel    * labelAnimated;
@end

@implementation TMEBrowserProductsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.topItem.title = NSLocalizedString(@"Browse Products", nil);
    
    [self.labelAnimated startAnimating];
    [self setUpCircleProgressIndicator];
    [self enablePullToRefresh];
    [self setUpTableView];
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
        [self loadProductsWithPage:++self.currentPage];
    };
    
    self.productsArrayDataSource = [[TMEBrowserProductsViewControllerArrayDataSource alloc] initWithItems:self.dataArray cellIdentifier:[TMEBrowserProductsTableCell kind] paging:self.paging handleCellBlock:handleLoadMoreCell delegate:self];
    
    self.tableView.dataSource = self.productsArrayDataSource;
    [self refreshTableViewAnimated:NO];
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
        if ([self.currentCategory.id isEqualToNumber:@8]) {
            [TMEProductsManager getPopularProductsWithPage:page
                                            onSuccessBlock:^(NSArray *arrProducts)
             {
                 [self loadSuccessHandleWithResponseArray:arrProducts page:page];
             }
                                              failureBlock:^(NSInteger statusCode, NSError *error)
             {
                 [self failureBlockHandleWithError:error];
                 [self finishLoading];
             }];
            return;
        }
        [TMEProductsManager getProductsOfCategory:self.currentCategory
                                         withPage:page
                                   onSuccessBlock:^(NSArray *arrProducts)
         {
             [self loadSuccessHandleWithResponseArray:arrProducts page:page];
         } failureBlock:^(NSInteger statusCode, NSError *error) {
             [self failureBlockHandleWithError:error];
             [self finishLoading];
         }];
        return;
    }
    
    [TMEProductsManager getAllProductsWihPage:page
                               onSuccessBlock:^(NSArray *arrProducts)
     {
         [self loadSuccessHandleWithResponseArray:arrProducts page:page];
     }
                                 failureBlock:^(NSInteger statusCode, NSError *error)
     {
         [self failureBlockHandleWithError:error];
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

- (void)paddingScrollWithTop
{
    CGFloat scrollViewTopInset = 44;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        scrollViewTopInset += 20;
    }
    self.tableView.contentInset = UIEdgeInsetsMake(scrollViewTopInset, 0, 40, 0);
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
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    [self.tableView setOrigin:CGPointMake(0, 0)];
    
    [self.pullToRefreshView beginRefreshing];
    self.navigationController.navigationBar.topItem.title = self.currentCategory.name;
}

#pragma mark - Button Like Action
- (void)onBtnLike:(UIButton *)sender label:(UILabel *)label{
    if (![self isReachable]) {
        return;
    }
    UITableViewCell *cell = [self getCellFromButton:sender];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    TMEProduct *currentCellProduct = self.dataArray[indexPath.section];
    sender.selected = !currentCellProduct.likedValue;
    
    if (!currentCellProduct.likedValue) {
        [TMEProductsManager likeProductWithProductID:currentCellProduct.id
                                      onSuccessBlock:^(NSString *status)
         {
             if (![status isEqualToString:@"success"]) {
                 [self likeProductFailureHandleButtonLike:sender currentCellProduct:currentCellProduct label:label unlike:NO];
             }
             currentCellProduct.likedValue = YES;
             [currentCellProduct likesIncrease];
             label.text = [@(label.text.integerValue + 1) stringValue];
             [self.tableView reloadData];
         }
                                        failureBlock:^(NSInteger statusCode, NSError *error)
         {
             [self likeProductFailureHandleButtonLike:sender currentCellProduct:currentCellProduct label:label unlike:NO];
         }];
        
        return;
    }
    
    [TMEProductsManager unlikeProductWithProductID:currentCellProduct.id
                                    onSuccessBlock:^(NSString *status)
     {
         if (![status isEqualToString:@"success"]) {
             [self likeProductFailureHandleButtonLike:sender currentCellProduct:currentCellProduct label:label unlike:YES];
         }
         currentCellProduct.likedValue = NO;
         [currentCellProduct likesIncrease];
         label.text = [@(label.text.integerValue - 1) stringValue];
         [self.tableView reloadData];
     }
                                                  failureBlock:^(NSInteger statusCode, NSError *error)
     {
         [self likeProductFailureHandleButtonLike:sender currentCellProduct:currentCellProduct label:label unlike:YES];
     }];
}

- (void)likeProductFailureHandleButtonLike:(UIButton *)sender currentCellProduct:(TMEProduct *)currentCellProduct label:(UILabel *)label unlike:(BOOL)flag{
    [UIAlertView showAlertWithTitle:NSLocalizedString(@"Something Wrong", nil) message:NSLocalizedString(@"Please try again later!", nil)];
    sender.selected = !currentCellProduct.likedValue;
    currentCellProduct.likedValue = !currentCellProduct.likedValue;
    
    if (flag) {
        [currentCellProduct likesIncrease];
        label.text = [@(label.text.integerValue + 1) stringValue];
        return;
    }
    
    [currentCellProduct likesDescrease];
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

- (void)loadSuccessHandleWithResponseArray:(NSArray *)array page:(NSInteger)page{
    [self handlePagingWithResponseArray:array currentPage:page];
    [self hidePlaceHolder];
    
    [self.dataArray addObjectsFromArray:array];
    
    [self setUpTableView];
    [self finishLoading];
    [self paddingScrollWithTop];
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
    newFrame.size.height = CGRectGetHeight([[UIScreen mainScreen]bounds]) - navBarHeightForVersionCheck;
    
    self.tableView.frame = newFrame;
    self.tableView.height = CGRectGetHeight(newFrame);
    self.currentNavBarHeight = fullScreenScroll.navigationBarHeight;
}

@end
