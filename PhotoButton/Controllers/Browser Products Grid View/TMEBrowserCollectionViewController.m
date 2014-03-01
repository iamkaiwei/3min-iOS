//
//  TMEBrowserCollectionViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 13/10/13.
//
//

#import "TMEBrowserCollectionViewController.h"
#import "TMEBrowserCollectionCell.h"
#import "TMELoadMoreCollectionViewCell.h"

@interface TMEBrowserCollectionViewController ()
<
UITextFieldDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property (weak, nonatomic) IBOutlet UICollectionView       * collectionProductsView;
@property (strong, nonatomic) TMECategory                   * currentCategory;

@end

@implementation TMEBrowserCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self paddingScrollWithTop];
    self.scrollableView = self.collectionProductsView;
    [self enablePullToRefresh];
    [self.collectionProductsView registerNib:[TMEBrowserCollectionCell defaultNib] forCellWithReuseIdentifier:[TMEBrowserCollectionCell kind]];
    
    [self.collectionProductsView registerNib:[TMELoadMoreCollectionViewCell defaultNib] forCellWithReuseIdentifier:[TMELoadMoreCollectionViewCell kind]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onCategoryChangeNotification:)
                                                 name:CATEGORY_CHANGE_NOTIFICATION
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self.collectionProductsView reloadData];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.paging){
        return self.arrayProducts.count + 1;
    }
    return self.arrayProducts.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.paging && indexPath.row == self.arrayProducts.count) {
        TMELoadMoreCollectionViewCell *cellLoadMore = [collectionView dequeueReusableCellWithReuseIdentifier:[TMELoadMoreCollectionViewCell kind] forIndexPath:indexPath];
        
        [cellLoadMore startLoading];
        
        [self loadProductsWithPage:self.currentPage++];
        //        self.handleCellBlock();
        return cellLoadMore;
    }
    TMEBrowserCollectionCell *cell = [self.collectionProductsView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TMEBrowserCollectionCell class]) forIndexPath:indexPath];
    [cell configCellWithData:self.arrayProducts[indexPath.row]];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.pullToRefreshView scrollViewDidScroll:scrollView];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    [self.pullToRefreshView scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
}

- (void)loadProductsWithPage:(NSInteger)page{
    if (![TMEReachabilityManager isReachable]) {
        [SVProgressHUD showErrorWithStatus:@"No connection!"];
        return;
    }
    
    if (self.currentCategory) {
        self.navigationController.navigationBar.topItem.title = self.currentCategory.name;
        if ([self.currentCategory.id isEqualToNumber:@8]) {
            [TMEProductsManager getPopularProductsWithPage:page
                                            onSuccessBlock:^(NSArray *arrProducts)
             {
                 [self handlePagingWithResponseArray:arrProducts currentPage:page];
                 
                 self.arrayProducts = [[self.arrayProducts arrayUniqueByAddingObjectsFromArray:arrProducts] mutableCopy];
                 self.arrayProducts = [[self.arrayProducts sortByAttribute:@"created_at" ascending:NO] mutableCopy];
                 
                 [self.collectionProductsView reloadData];
                 [self.pullToRefreshView endRefreshing];
             }
                                              failureBlock:^(NSInteger statusCode, id obj)
             {
                 [self.pullToRefreshView endRefreshing];
             }];
            return;
        }
        
        [TMEProductsManager getProductsOfCategory:self.currentCategory
                                         withPage:page
                                   onSuccessBlock:^(NSArray *arrProducts)
         {
             [self handlePagingWithResponseArray:arrProducts currentPage:page];
             
             self.arrayProducts = [[self.arrayProducts arrayUniqueByAddingObjectsFromArray:arrProducts] mutableCopy];
             self.arrayProducts = [[self.arrayProducts sortByAttribute:@"created_at" ascending:NO] mutableCopy];
             
             [self.collectionProductsView reloadData];
             [self.pullToRefreshView endRefreshing];
         }
                                     failureBlock:^(NSInteger statusCode, id obj)
         {
             [self.pullToRefreshView endRefreshing];
         }];
        return;
    }
    [TMEProductsManager getAllProductsWihPage:page
                               onSuccessBlock:^(NSArray *arrProducts)
     {
         [self handlePagingWithResponseArray:arrProducts currentPage:page];
         
         self.arrayProducts = [[self.arrayProducts arrayUniqueByAddingObjectsFromArray:arrProducts] mutableCopy];
         self.arrayProducts = [[self.arrayProducts sortByAttribute:@"created_at" ascending:NO] mutableCopy];
         
         [self.collectionProductsView reloadData];
         [self.pullToRefreshView endRefreshing];
     }
                                 failureBlock:^(NSInteger statusCode, id obj)
     {
         [self.pullToRefreshView endRefreshing];
     }];
}

#pragma mark - SSPullToRefreshView delegate
- (void)pullToRefreshViewDidStartLoading
{
    if (![TMEReachabilityManager isReachable]) {
        [SVProgressHUD showErrorWithStatus:@"No connection!"];
        [self.pullToRefreshView endRefreshing];
        return;
    }
    
    [self loadProductsWithPage:1];
}


#pragma mark - Utilities
- (void)paddingScrollWithTop
{
    CGFloat scrollViewTopInset = 44;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        scrollViewTopInset += 20;
    }
    self.collectionProductsView.contentInset = UIEdgeInsetsMake(scrollViewTopInset, 0, 0, 0);
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
