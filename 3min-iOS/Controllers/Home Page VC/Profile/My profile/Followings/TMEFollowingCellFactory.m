//
//  TMEFollowingCellFactory.m
//  ThreeMin
//
//  Created by Triệu Khang on 1/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEFollowingCellFactory.h"
#import "KHCollectionContentLoadingCellFactory.h"
#import "KHContentLoadingSectionViewModel.h"

@implementation TMEFollowingCellFactory

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath model:(id <KHTableViewModel> )model {
	if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[KHContentLoadingSectionViewModel class]]) {
		return [[[KHCollectionContentLoadingCellFactory alloc] init] collectionView:collectionView sizeForItemAtIndexPath:indexPath model:model];
	}

	if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[KHLoadMoreSection class]]) {
		return CGSizeMake(collectionView.frame.size.width, 50);
	}

	return CGSizeMake(collectionView.frame.size.width, 50);
}

- (UICollectionViewCell <KHCellProtocol> *)collectionView:(UICollectionView *)collection cellAtIndexPath:(NSIndexPath *)indexPath withModel:(id <KHTableViewModel> )model {
	if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[KHContentLoadingSectionViewModel class]]) {
		return [[[KHCollectionContentLoadingCellFactory alloc] init] collectionView:collection cellAtIndexPath:indexPath withModel:model];
	}

	if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[KHLoadMoreSection class]]) {
		return [[[KHCollectionContentLoadingCellFactory alloc] init] collectionView:collection cellAtIndexPath:indexPath withModel:model];
	}

	TMEFollowingCollectionViewCell <KHCellProtocol> *cell = (TMEFollowingCollectionViewCell <KHCellProtocol> *) [self _getReusableCellWithClass:[TMEFollowingCollectionViewCell class] collectionView:collection atIndexPath:indexPath];
	[cell configWithData:[model itemAtIndexpath:indexPath]];
    cell.delegate = self.cellDelegate;
	return cell;
}

@end
