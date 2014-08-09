//
//  TMEBrowserCollectionViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 13/10/13.
//
//

#import "TMEBrowserCollectionViewController.h"
#import "TMEBrowserCollectionCell.h"
#import "TMEBrowserCollectionViewDataSource.h"
#import "TMELoadMoreCollectionViewCell.h"

@interface TMEBrowserCollectionViewController ()
<
UITextFieldDelegate,
UICollectionViewDelegate
>

@property (weak, nonatomic) IBOutlet UICollectionView       * collectionProductsView;
@property (strong, nonatomic) TMEBrowserCollectionViewDataSource * productsArrayDataSource;

@end

@implementation TMEBrowserCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self paddingScrollWithTop];
    [self setUpCollectionView];
    self.scrollableView = self.collectionProductsView;
    [self enablePullToRefresh];
    
    [self.collectionProductsView registerNib:[TMEBrowserCollectionCell defaultNib] forCellWithReuseIdentifier:[TMEBrowserCollectionCell kind]];
    
    [self.collectionProductsView registerNib:[TMELoadMoreCollectionViewCell defaultNib] forCellWithReuseIdentifier:[TMELoadMoreCollectionViewCell kind]];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onCategoryChangeNotification:)
                                                 name:CATEGORY_CHANGE_NOTIFICATION
                                               object:nil];
}

- (void)setUpCollectionView{
    LoadMoreCellHandleBlock handleLoadMore = ^(){
        [self loadProductsWithPage:++self.currentPage];
    };
    self.productsArrayDataSource = [[TMEBrowserCollectionViewDataSource alloc] initWithItems:self.arrayProducts cellIdentifier:[TMEBrowserCollectionCell kind] paging:self.paging delegate:self handleCellBlock:handleLoadMore];
    
    self.collectionProductsView.dataSource = self.productsArrayDataSource;
    [self.collectionProductsView reloadData];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(didSelectCellAnimation)]) {
        [cell performSelector:@selector(didSelectCellAnimation)];
    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(didDeselectCellAnimation)]) {
        [cell performSelector:@selector(didDeselectCellAnimation)];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TMEProductDetailsViewController *productDetailsController = [[TMEProductDetailsViewController alloc] init];
    productDetailsController.product = self.arrayProducts[indexPath.row];
    productDetailsController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:productDetailsController animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.pullToRefreshView scrollViewDidScroll:scrollView];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    [self.pullToRefreshView scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
}

- (void)loadProductsWithPage:(NSInteger)page{
    if (![TMEReachabilityManager isReachable]) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"No connection!", nil)];
        return;
    }
    
    if (self.currentCategory) {
        self.navigationController.navigationBar.topItem.title = self.currentCategory.name;
        if ([self.currentCategory.categoryId isEqualToNumber:@8]) {
            [TMEProductsManager getPopularProductsWithPage:page
                                            onSuccessBlock:^(NSArray *arrProducts)
             {
                 [self successBlockHandleWithResponseArray:arrProducts page:page];
             }
                                              failureBlock:^(NSError *error)
             {
                 [self failureBlockHandleWithError:error];
                 [self.pullToRefreshView endRefreshing];
             }];
            return;
        }
        
        [TMEProductsManager getProductsOfCategory:self.currentCategory
                                         withPage:page
                                   onSuccessBlock:^(NSArray *arrProducts)
         {
             [self successBlockHandleWithResponseArray:arrProducts page:page];
         }
                                     failureBlock:^(NSError *error)
         {
             [self failureBlockHandleWithError:error];
             [self.pullToRefreshView endRefreshing];
         }];
        return;
    }
    [TMEProductsManager getAllProductsWihPage:page
                               onSuccessBlock:^(NSArray *arrProducts)
     {
         [self successBlockHandleWithResponseArray:arrProducts page:page];
     }
                                 failureBlock:^(NSError *error)
     {
         [self failureBlockHandleWithError:error];
         [self.pullToRefreshView endRefreshing];
     }];
}

#pragma mark - SSPullToRefreshView delegate
- (void)pullToRefreshViewDidStartLoading
{
    if (![TMEReachabilityManager isReachable]) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"No connection!", nil)];
        [self.pullToRefreshView endRefreshing];
        return;
    }
    [self loadProductsWithPage:1];
}

- (void)successBlockHandleWithResponseArray:(NSArray *)responseArray page:(NSInteger)page{
    [self handlePagingWithResponseArray:responseArray currentPage:page];
    [self.arrayProducts addObjectsFromArray:responseArray];
    [self setUpCollectionView];
    [self.pullToRefreshView endRefreshing];
}

#pragma mark - Utilities
- (void)paddingScrollWithTop
{
    CGFloat scrollViewTopInset = 44;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        scrollViewTopInset += 20;
    }
    self.collectionProductsView.contentInset = UIEdgeInsetsMake(scrollViewTopInset, 0, 44, 0);
}

#pragma mark - Notifications
- (void)onCategoryChangeNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    if ([self.currentCategory isEqual:userInfo[@"category"]]) {
        return;
    }
    self.currentCategory= [userInfo objectForKey:@"category"];
    [self.collectionProductsView setContentOffset:CGPointMake(0, -60) animated:YES];
    [self.pullToRefreshView beginRefreshing];
}

- (void)handlePagingWithResponseArray:(NSArray *)array currentPage:(NSInteger)page{
    if (page == 1) {
        [self.arrayProducts removeAllObjects];
    }
    if (!self.currentPage) {
        self.currentPage = page;
    }
    if (!array.count) {
        self.paging = NO;
        return;
    }
    self.paging = YES;
}

@end
