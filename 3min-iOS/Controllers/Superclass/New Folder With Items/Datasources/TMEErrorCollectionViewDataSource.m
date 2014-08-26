//
//  TMEErrorCollectionViewDataSource.m
//  ThreeMin
//
//  Created by Triệu Khang on 20/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEErrorCollectionViewDataSource.h"
#import "TMEErrorReusableCollectionView.h"

@class TMEErrorReusableCollectionView;

@implementation TMEErrorCollectionViewDataSource

- (void)setCellAndFooterClasses:(UICollectionView *)collectionView {
    [collectionView registerNib:[TMEErrorReusableCollectionView defaultNib] forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter withReuseIdentifier:@"TMEErrorReusableCollectionView"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *errorView = (UICollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([TMEErrorReusableCollectionView class]) forIndexPath:indexPath];
    return errorView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	return CGSizeZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section {
    return [UIScreen mainScreen].bounds.size.height;
}

@end
