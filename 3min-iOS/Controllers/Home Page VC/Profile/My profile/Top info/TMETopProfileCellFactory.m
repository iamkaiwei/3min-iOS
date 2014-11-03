//
//  TMETopProfileCellFactory.m
//  ThreeMin
//
//  Created by Triệu Khang on 29/10/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMETopProfileCellFactory.h"
#import "KHCollectionContentLoadingCellFactory.h"
#import "TMETopProfileCollectionViewCell.h"
#import "KHContentLoadingCollectionCell.h"

@implementation TMETopProfileCellFactory

- (UICollectionViewCell <KHCellProtocol> *)collectionView:(UICollectionView *)collection cellAtIndexPath:(NSIndexPath *)indexPath withModel:(id <KHTableViewModel> )model {
	if ([[model sectionAtIndex:0] isKindOfClass:[KHLoadMoreSection class]]) {
		id <KHCollectionViewCellFactoryProtocol> factory = [[KHCollectionContentLoadingCellFactory alloc] init];
		return [factory collectionView:collection cellAtIndexPath:indexPath withModel:model];
	}

	TMETopProfileCollectionViewCell <KHCellProtocol> *cell = (TMETopProfileCollectionViewCell *) [self _getReusableCellWithClass:[TMETopProfileCollectionViewCell class] collectionView:collection atIndexPath:indexPath];
    [cell configWithData:[model itemAtIndexpath:indexPath]];
    cell.delegate = self.delegate;

	return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath model:(id <KHTableViewModel> )model {
	return CGSizeMake(collectionView.width, 160);
}

@end
