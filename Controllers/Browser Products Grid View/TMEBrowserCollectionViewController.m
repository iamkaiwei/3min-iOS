//
//  TMEBrowserCollectionViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 13/10/13.
//
//

#import "TMEBrowserCollectionViewController.h"
#import "TMEBrowserCollectionCell.h"
#import "TMEProductDetailsViewController.h"

@interface TMEBrowserCollectionViewController ()
<
UITextFieldDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate,
SSPullToRefreshViewDelegate
>

@property (weak, nonatomic) IBOutlet UICollectionView       * collectionProductsView;
@property (strong, nonatomic) NSArray                       * arrayProducts;
@property (strong, nonatomic) TMECategory                   * currentCategory;
@property (strong, nonatomic) SSPullToRefreshView           * pullToRefreshView;

@end

@implementation TMEBrowserCollectionViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  [self paddingScrollWithTop];
  [self.collectionProductsView registerNib:[TMEBrowserCollectionCell defaultNib] forCellWithReuseIdentifier:NSStringFromClass([TMEBrowserCollectionCell class])];
  
  self.pullToRefreshView = [[SSPullToRefreshView alloc] initWithScrollView:self.collectionProductsView delegate:self];
  
  [self loadProducts];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCategoryChangeNotification:) name:CATEGORY_CHANGE_NOTIFICATION object:nil];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  TMEProductDetailsViewController *productDetailsController = [[TMEProductDetailsViewController alloc] init];
  productDetailsController.product = self.arrayProducts[indexPath.row];
  [self.navigationController pushViewController:productDetailsController animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return [self.arrayProducts count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  TMEBrowserCollectionCell *cell = [self.collectionProductsView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TMEBrowserCollectionCell class]) forIndexPath:indexPath];
  
  TMEProduct *product = [self.arrayProducts objectAtIndex:indexPath.row];
  [cell configCellWithProduct:product];
  
  return cell;
}

- (void)loadProducts {
  if (self.currentCategory) {
    [[TMEProductsManager sharedInstance] getProductsOfCategory:self.currentCategory
                                                onSuccessBlock:^(NSArray *arrProducts) {
                                                  self.arrayProducts = [arrProducts mutableCopy];
                                                  [self.collectionProductsView reloadData];
                                                  [self.pullToRefreshView finishLoading];
                                                    [SVProgressHUD dismiss];
                                                } andFailureBlock:^(NSInteger statusCode, id obj) {
                                                  [self.pullToRefreshView finishLoading];
                                                    [SVProgressHUD dismiss];
                                                }];
  } else {
    [[TMEProductsManager sharedInstance] getAllProductsOnSuccessBlock:^(NSArray *arrProducts) {
      self.arrayProducts = [arrProducts mutableCopy];
      [self.collectionProductsView reloadData];
      
      [self.pullToRefreshView finishLoading];
      [SVProgressHUD dismiss];
    } andFailureBlock:^(NSInteger statusCode, id obj) {
      [self.pullToRefreshView finishLoading];
      [SVProgressHUD dismiss];
    }];
  }
}

#pragma mark - SSPullToRefreshView delegate
- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view
{
  [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
  [self loadProducts];
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
  [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
  NSDictionary *userInfo = [notification userInfo];
  self.currentCategory= [userInfo objectForKey:@"category"];
  [self loadProducts];
}
@end
