//
//  TMESimpleCollectionDatasource.h
//  ThreeMin
//
//  Created by Triệu Khang on 1/10/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMESimpleCollectionDatasource : NSObject
<
    UICollectionViewDataSource
>

- (instancetype)initWithViewModel:(id<TMEViewModelProtocol>)vm collectionView:(UICollectionView *)collectionView andCellClass:(Class)cellClass;

@end
