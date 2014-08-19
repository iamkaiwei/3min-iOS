//
//  TMEPaginationCollectionViewDataSource.h
//  ThreeMin
//
//  Created by Triệu Khang on 15/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "FPCollectionArrayDataSource.h"
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>

@interface TMEPaginationCollectionViewDataSource : FPCollectionArrayDataSource
<
    CHTCollectionViewDelegateWaterfallLayout
>

- (void)setClassAndFooterClasses:(UICollectionView *)collectionView;

@end
