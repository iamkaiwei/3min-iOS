//
//  TMEPaginationCollectionViewErrorDataSource.m
//  ThreeMin
//
//  Created by Triệu Khang on 19/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEPaginationCollectionViewErrorDataSource.h"
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>

@implementation TMEPaginationCollectionViewErrorDataSource

#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter withReuseIdentifier:@"TMEErrorReusableCollectionView" forIndexPath:indexPath];
    return footer;
}

@end
