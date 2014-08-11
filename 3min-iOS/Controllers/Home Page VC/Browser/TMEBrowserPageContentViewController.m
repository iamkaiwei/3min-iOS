//
//  TMEBrowserPageContentViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEBrowserPageContentViewController.h"
#import "TMEProductCollectionViewCell.h"
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>

@interface TMEBrowserPageContentViewController ()
<
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    CHTCollectionViewDelegateWaterfallLayout
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewProducts;
@property (strong, nonatomic) NSArray *arrProducts;

@end

@implementation TMEBrowserPageContentViewController

#pragma mark - VC cycle

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.

    [self configCollectionProducts];

	self.arrProducts = @[];
}

#pragma mark -

- (void)configCollectionProducts {
	[self.collectionViewProducts registerNib:[TMEProductCollectionViewCell defaultNib]
	              forCellWithReuseIdentifier:NSStringFromClass([TMEProductCollectionViewCell class])];

	self.collectionViewProducts.collectionViewLayout = [self waterFlowLayout];
	self.collectionViewProducts.delegate = self;
	self.collectionViewProducts.dataSource = self;
    [self.collectionViewProducts setContentInset:UIEdgeInsetsMake(10, 0, 10, 0)];
}

#pragma mark -

- (UICollectionViewLayout *)waterFlowLayout {
	CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
	layout.columnCount = 2;
	layout.minimumColumnSpacing = 5;
	layout.minimumInteritemSpacing = 6;
    return layout;
}

- (IBAction)reload:(id)sender {
	[TMEProductsManager getAllProductsWihPage:1
	                           onSuccessBlock: ^(NSArray *arrProducts) {
	    self.arrProducts = arrProducts;
	    [self.collectionViewProducts reloadData];
	} failureBlock: ^(NSError *error) {
	}];
}

#pragma mark - Collection datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.arrProducts.count;
}

- (TMEProductCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	TMEProductCollectionViewCell *cell = (TMEProductCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TMEProductCollectionViewCell class]) forIndexPath:indexPath];
	TMEProduct *product = self.arrProducts[indexPath.row];
	[cell configWithData:product];

	return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	return CGSizeMake(152, 330);
}

@end
