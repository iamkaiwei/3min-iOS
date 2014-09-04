//
//  TMEPaginationCollectionViewDataSource.m
//  ThreeMin
//
//  Created by Triệu Khang on 15/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "FPCollectionArrayDataSource.h"
#import "TMEPaginationCollectionViewDataSource.h"
#import "TMEProductCollectionViewCell.h"
#import "TMELoadMoreCollectionFooterView.h"
#import "TMEProductCollectionViewCell+Template.h"
#import "TMEProduct+ProductCellHeight.h"
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>

static const CGFloat kProductCollectionCellStaticInfoHeight = 128;
static const CGFloat kProductCollectionCellWidth = 152;

@interface TMEPaginationCollectionViewDataSource ()
<
    UICollectionViewDataSource
>

@property (copy, nonatomic, readwrite) NSArray *items;
@property (copy, nonatomic) IdentifierParserBlock identifierParserBlock;
@property (copy, nonatomic) CollectionViewCellConfigureBlock configureCellBlock;

@end

@implementation TMEPaginationCollectionViewDataSource

- (id)initWithViewModel:(id)viewModel {
	self = [super init];
	if (self) {
	}

	return self;
}

#pragma mark -

- (void)setCellAndFooterClasses:(UICollectionView *)collectionView {
	[collectionView    registerNib:[TMEProductCollectionViewCell defaultNib]
	    forCellWithReuseIdentifier:NSStringFromClass([TMEProductCollectionViewCell class])];
	[collectionView    registerNib:[TMELoadMoreCollectionFooterView defaultNib]
	    forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
	           withReuseIdentifier:NSStringFromClass([TMELoadMoreCollectionFooterView class])];
}

#pragma mark -

- (IdentifierParserBlock)identifierParserBlock {
	IdentifierParserBlock identifierParserBlock = ^NSString *(id item)
	{
		return NSStringFromClass([TMEProductCollectionViewCell class]);
	};
	return identifierParserBlock;
}

- (CollectionViewCellConfigureBlock)configureCellBlock {
	CollectionViewCellConfigureBlock configBlock = ^(id cell, id item) {
		[self configNormalCell:cell item:item];
	};
	return configBlock;
}

- (void)configNormalCell:(id)cell item:(id)item {
	TMEProductCollectionViewCell *productCell = (TMEProductCollectionViewCell *)cell;
	[productCell configWithData:item];
    [productCell loadImages:item];
    productCell.delegate = (id) self.ownerViewController;
}

- (void)configLoadMoreCell:(id)cell item:(id)item {
}

#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	id item = [self itemAtIndex:indexPath.row];
	NSString *identifier = self.identifierParserBlock(item);
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
	self.configureCellBlock(cell, item);
	return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	TMELoadMoreCollectionFooterView *footer = (TMELoadMoreCollectionFooterView *)[collectionView dequeueReusableSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([TMELoadMoreCollectionFooterView class]) forIndexPath:indexPath];
	return footer;
}

#pragma mark -

- (id)itemAtIndex:(NSUInteger)index {
	if (index > self.items.count) {
		return nil;
	}

	return self.items[index];
}

#pragma mark - Collection datasource

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat cellWidth = kProductCollectionCellWidth;
	TMEProduct *product = [self itemAtIndex:indexPath.row];
	return CGSizeMake(cellWidth, [product productCellHeight]);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section {
	return 50;
}

@end
