//
//  TMEBrowserPageContentViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEBrowserPageContentViewController.h"
#import "TMEProductCollectionViewCell.h"
#import "WaterFlowLayout.h"

@interface TMEBrowserPageContentViewController ()
<
    UICollecitonViewDelegateWaterFlowLayout,
    UICollectionViewDataSourceWaterFlowLayout
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewProducts;

@end

@implementation TMEBrowserPageContentViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.

	[self.collectionViewProducts registerClass:[TMEProductCollectionViewCell class]
	                forCellWithReuseIdentifier:NSStringFromClass([TMEProductCollectionViewCell class])];

    WaterFlowLayout *cvLayout = [[WaterFlowLayout alloc] init];
    cvLayout.flowdatasource = self;
    cvLayout.flowdelegate = self;
    self.collectionViewProducts.collectionViewLayout = cvLayout;

    self.collectionViewProducts.delegate = self;
    self.collectionViewProducts.dataSource = self;
}

- (NSInteger)numberOfColumnsInFlowLayout:(WaterFlowLayout *)flowlayout
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (TMEProductCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TMEProductCollectionViewCell *cell = (TMEProductCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TMEProductCollectionViewCell class]) forIndexPath:indexPath];
    [cell configWithData:[[TMEProduct alloc] init]];
    return cell;
}

- (CGFloat)flowLayout:(WaterFlowLayout *)flowView heightForRowAtIndex:(int)i {
    return 300.0f;
}

@end
