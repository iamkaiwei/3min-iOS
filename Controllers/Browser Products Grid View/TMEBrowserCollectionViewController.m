//
//  TMEBrowserViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 13/10/13.
//
//

#import "TMEBrowserCollectionViewController.h"
#import "TMEBrowserCollectionCell.h"

@interface TMEBrowserCollectionViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionProducts;

@end

@implementation TMEBrowserCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.collectionProducts registerNib:[TMEBrowserCollectionCell defaultNib] forCellWithReuseIdentifier:NSStringFromClass([TMEBrowserCollectionCell class])];
}

#pragma mark - Collection datasoure
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TMEBrowserCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TMEBrowserCollectionCell class]) forIndexPath:indexPath];
    
    return cell;
}

@end
