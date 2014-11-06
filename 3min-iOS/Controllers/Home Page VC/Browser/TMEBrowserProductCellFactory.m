//
//  TMEBrowserProductCellFactory.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEBrowserProductCellFactory.h"
#import <KHTableViewController/KHContentLoadingSectionViewModel.h>
#import "TMEProduct+ProductCellHeight.h"
#import "TMEProductCollectionViewCell.h"
#import "KHOrderedDataProvider.h"

@interface TMEBrowserProductCellFactory()

@end

@implementation TMEBrowserProductCellFactory

#pragma mark -

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath model:(id <KHTableViewModel> )model {

	if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[KHContentLoadingSectionViewModel class]]) {
		return [[[KHCollectionContentLoadingCellFactory alloc] init] collectionView:collectionView sizeForItemAtIndexPath:indexPath model:model];
	}

    if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[KHLoadMoreSection class]]) {
        return CGSizeMake(320, 0);
    }

    KHOrderedDataProvider *dataProvider = (KHOrderedDataProvider *) [model sectionAtIndex:indexPath.section];
    TMEProduct *product = [dataProvider objectAtIndex:indexPath.item withTriggerPagination:NO];
	return CGSizeMake(150, [product productCellHeight]);
}

- (UICollectionViewCell <KHCellProtocol> *)collectionView:(UICollectionView *)collection cellAtIndexPath:(NSIndexPath *)indexPath withModel:(id <KHTableViewModel> )model {
	if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[KHContentLoadingSectionViewModel class]]) {
		return [[[KHCollectionContentLoadingCellFactory alloc] init] collectionView:collection cellAtIndexPath:indexPath withModel:model];
	}

    if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[KHLoadMoreSection class]]) {
        return nil;
    }

	TMEProductCollectionViewCell <KHCellProtocol> *cell = (TMEProductCollectionViewCell <KHCellProtocol> *) [self _getReusableCellWithClass:[TMEProductCollectionViewCell class] collectionView:collection atIndexPath:indexPath];
	[cell configWithData:[model itemAtIndexpath:indexPath]];
    [cell loadImages:[model itemAtIndexpath:indexPath]];
    cell.delegate = self.delegate;
	return cell;
}

@end
