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

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.

	[self.collectionViewProducts registerNib:[TMEProductCollectionViewCell defaultNib]
	              forCellWithReuseIdentifier:NSStringFromClass([TMEProductCollectionViewCell class])];

	CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
	layout.columnCount = 2;
	layout.minimumColumnSpacing = 5;
	layout.minimumInteritemSpacing = 6;
	self.collectionViewProducts.collectionViewLayout = layout;

	self.collectionViewProducts.delegate = self;
	self.collectionViewProducts.dataSource = self;

	self.arrProducts = @[];
}

- (IBAction)reload:(id)sender {
	[TMEProductsManager getAllProductsWihPage:1
	                           onSuccessBlock: ^(NSArray *arrProducts) {
	    self.arrProducts = arrProducts;
	    [self.collectionViewProducts reloadData];
	} failureBlock: ^(NSError *error) {
	}];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.arrProducts.count;
}

- (TMEProductCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	TMEProductCollectionViewCell *cell = (TMEProductCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TMEProductCollectionViewCell class]) forIndexPath:indexPath];
	TMEProduct *product = self.arrProducts[indexPath.row];
	[cell configWithData:product];

//	cell.layer.cornerRadius = 4.0f;
//	cell.layer.masksToBounds = YES;
//	cell.layer.shadowColor = [UIColor colorWithHexString:@"#333"].CGColor;
//	cell.layer.shadowRadius = 4.0f;

	return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	return CGSizeMake(152, 330);
}

@end
