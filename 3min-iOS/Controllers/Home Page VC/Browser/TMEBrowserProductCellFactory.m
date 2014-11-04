//
//  TMEBrowserProductCellFactory.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEBrowserProductCellFactory.h"
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>

@interface TMEBrowserProductCellFactory()

@property (strong, nonatomic) CHTCollectionViewWaterfallLayout *waterFlowLayout;

@end

@implementation TMEBrowserProductCellFactory

#pragma mark -

- (CHTCollectionViewWaterfallLayout *)waterFlowLayout {
	CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
	layout.columnCount = 2;
	layout.minimumColumnSpacing = 5;
	layout.minimumInteritemSpacing = 6;
	return layout;
}

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath model:(id <KHTableViewModel> )model {
//	if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[KHContentLoadingSectionViewModel class]]) {
//		return [[[KHCollectionContentLoadingCellFactory alloc] init] collectionView:collectionView sizeForItemAtIndexPath:indexPath model:model];
//	}

	if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[KHLoadMoreSection class]]) {
		return CGSizeMake(collectionView.frame.size.width, 50);
	}

	return CGSizeMake(collectionView.frame.size.width, 50);
}

- (UICollectionViewCell <KHCellProtocol> *)collectionView:(UICollectionView *)collection cellAtIndexPath:(NSIndexPath *)indexPath withModel:(id <KHTableViewModel> )model {
//	if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[KHContentLoadingSectionViewModel class]]) {
//		return [[[KHCollectionContentLoadingCellFactory alloc] init] collectionView:collection cellAtIndexPath:indexPath withModel:model];
//	}

	if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[KHLoadMoreSection class]]) {
		return [[[KHCollectionContentLoadingCellFactory alloc] init] collectionView:collection cellAtIndexPath:indexPath withModel:model];
	}

//	TMEFollowingCollectionViewCell <KHCellProtocol> *cell = (TMEFollowingCollectionViewCell <KHCellProtocol> *) [self _getReusableCellWithClass:[TMEFollowingCollectionViewCell class] collectionView:collection atIndexPath:indexPath];
//	[cell configWithData:[model itemAtIndexpath:indexPath]];
//	return cell;

    return nil;
}

@end
