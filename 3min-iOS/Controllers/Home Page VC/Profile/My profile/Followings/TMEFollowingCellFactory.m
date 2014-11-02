//
//  TMEFollowingCellFactory.m
//  ThreeMin
//
//  Created by Triệu Khang on 1/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEFollowingCellFactory.h"
#import "KHCollectionContentLoadingCellFactory.h"
#import "TMEFollowingCollectionViewCell.h"

@implementation TMEFollowingCellFactory

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath model:(id<KHTableViewModel>)model {
    if ([[model sectionAtIndex:0] isKindOfClass:[KHLoadMoreSection class]]) {
        return [[[KHCollectionContentLoadingCellFactory alloc] init] collectionView:collectionView sizeForItemAtIndexPath:indexPath model:model];
    }

    return CGSizeMake(collectionView.frame.size.width, 60);
}

- (UICollectionViewCell<KHCellProtocol> *)collectionView:(UICollectionView *)collection cellAtIndexPath:(NSIndexPath *)indexPath withModel:(id<KHTableViewModel>)model {
    if ([[model sectionAtIndex:0] isKindOfClass:[KHLoadMoreSection class]]) {
        return [[[KHCollectionContentLoadingCellFactory alloc] init] collectionView:collection cellAtIndexPath:indexPath withModel:model];
    }

    TMEFollowingCollectionViewCell<KHCellProtocol> *cell = [self _getReusableCellWithClass:[TMEFollowingCollectionViewCell class] collectionView:collection atIndexPath:indexPath];
    return cell;
}

@end
