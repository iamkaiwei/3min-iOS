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
<UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionProductsView;

@end

@implementation TMEBrowserCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.collectionProductsView registerClass:[TMEBrowserCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([TMEBrowserCollectionCell class])];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(150, 190)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionProductsView.collectionViewLayout = flowLayout;
    self.collectionProductsView.backgroundColor = [UIColor grayColor];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TMEBrowserCollectionCell *cell = [self.collectionProductsView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TMEBrowserCollectionCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(150, 190);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

@end
