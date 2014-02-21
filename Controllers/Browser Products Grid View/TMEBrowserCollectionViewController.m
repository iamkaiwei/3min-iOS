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
UICollectionViewDelegate
>

@property (weak, nonatomic) IBOutlet UICollectionView       * collectionProductsView;
@property (strong, nonatomic) TMECategory                   * currentCategory;
@property (strong, nonatomic) UIRefreshControl           * pullToRefreshView;

@end

@implementation TMEBrowserCollectionViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  [self paddingScrollWithTop];
  [self.collectionProductsView registerNib:[TMEBrowserCollectionCell defaultNib] forCellWithReuseIdentifier:NSStringFromClass([TMEBrowserCollectionCell class])];
  
  self.scrollableView = self.collectionProductsView;
  [self enablePullToRefresh];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCategoryChangeNotification:) name:CATEGORY_CHANGE_NOTIFICATION object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return [self.arrayProducts count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  TMEBrowserCollectionCell *cell = [self.collectionProductsView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TMEBrowserCollectionCell class]) forIndexPath:indexPath];
  
  TMEProduct *product = [self.arrayProducts objectAtIndex:indexPath.row];
  [cell configCellWithData:product];
  
  return cell;
}

- (void)loadProducts{
  if (![TMEReachabilityManager isReachable]) {
    [SVProgressHUD showErrorWithStatus:@"No connection!"];
    return;
  }
  
  [SVProgressHUD showWithStatus:@"Loading products..." maskType:SVProgressHUDMaskTypeGradient];
  if (self.currentCategory) {
    [[TMEProductsManager sharedInstance] getProductsOfCategory:self.currentCategory
                                                onSuccessBlock:^(NSArray *arrProducts) {
                                                  self.arrayProducts = [arrProducts mutableCopy];
                                                  [self.collectionProductsView reloadData];
                                                  [self.pullToRefreshView endRefreshing];
                                                    [SVProgressHUD dismiss];
                                                } andFailureBlock:^(NSInteger statusCode, id obj) {
                                                  [self.pullToRefreshView endRefreshing];
                                                    [SVProgressHUD dismiss];
                                                }];
  } else {
    [[TMEProductsManager sharedInstance] getAllProductsOnSuccessBlock:^(NSArray *arrProducts) {
      self.arrayProducts = [arrProducts mutableCopy];
      [self.collectionProductsView reloadData];
      
      [self.pullToRefreshView endRefreshing];
      [SVProgressHUD dismiss];
    } andFailureBlock:^(NSInteger statusCode, id obj) {
      [self.pullToRefreshView endRefreshing];
      [SVProgressHUD dismiss];
    }];
  }
}

#pragma mark - SSPullToRefreshView delegate
- (void)pullToRefreshViewDidStartLoading:(UIRefreshControl *)view
{
  if (![TMEReachabilityManager isReachable]) {
    [SVProgressHUD showErrorWithStatus:@"No connection!"];
    [self.pullToRefreshView endRefreshing];
    return;
  }
  
  NSDateFormatter *formattedDate = [[NSDateFormatter alloc]init];
  [formattedDate setDateFormat:@"d MMM, h:mm a"];
  NSString *lastupdated = [NSString stringWithFormat:@"Last Updated on %@",[formattedDate stringFromDate:[NSDate date]]];
  self.pullToRefreshView.attributedTitle = [[NSAttributedString alloc]initWithString:lastupdated];
  
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
  self.navigationController.navigationBar.topItem.title = self.currentCategory.name;
  [self loadProducts];
}

@end
