//
//  TMEBrowserCollectionViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 13/10/13.
//
//

#import "TMEBrowserCollectionViewController.h"
#import "TMEBrowserCollectionCell.h"

@interface TMEBrowserCollectionViewController ()
<
UITextFieldDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
SSPullToRefreshViewDelegate
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionProductsView;
@property (strong, nonatomic) NSArray *arrayProducts;
@property (strong, nonatomic) TMECategory * currentCategory;
@property (strong, nonatomic) SSPullToRefreshView           *pullToRefreshView;

@end

@implementation TMEBrowserCollectionViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  [self paddingScrollWithTop];
  [self.collectionProductsView registerNib:[TMEBrowserCollectionCell defaultNib] forCellWithReuseIdentifier:NSStringFromClass([TMEBrowserCollectionCell class])];
  
  UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
  [flowLayout setItemSize:CGSizeMake(153, 190)];
  [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
  
  self.collectionProductsView.collectionViewLayout = flowLayout;
  self.collectionProductsView.backgroundColor = [UIColor colorWithHexString:@"#e4e2e1"];
  
  self.pullToRefreshView = [[SSPullToRefreshView alloc] initWithScrollView:self.collectionProductsView delegate:self];
  
  [self loadProducts];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCategoryChangeNotification:) name:CATEGORY_CHANGE_NOTIFICATION object:nil];
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(153, 190);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
  return UIEdgeInsetsMake(0, 2, 0, 2);
}

- (void)loadProducts {
  if (self.currentCategory) {
    [[TMEProductsManager sharedInstance] getProductsOfCategory:self.currentCategory
                                                onSuccessBlock:^(NSArray *arrProducts) {
                                                  self.arrayProducts = [arrProducts mutableCopy];
                                                  [self.collectionProductsView reloadData];
                                                  [self.pullToRefreshView finishLoading];
                                                } andFailureBlock:^(NSInteger statusCode, id obj) {
                                                  [self.pullToRefreshView finishLoading];
                                                }];
  } else {
    [[TMEProductsManager sharedInstance] getAllProductsOnSuccessBlock:^(NSArray *arrProducts) {
      self.arrayProducts = [arrProducts mutableCopy];
      [self.collectionProductsView reloadData];
      
      [self.pullToRefreshView finishLoading];
    } andFailureBlock:^(NSInteger statusCode, id obj) {
      [self.pullToRefreshView finishLoading];
    }];
  }
}

#pragma mark - SSPullToRefreshView delegate
- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view
{
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
  NSDictionary *userInfo = [notification userInfo];
  self.currentCategory= [userInfo objectForKey:@"category"];
  [self loadProducts];
}
@end
