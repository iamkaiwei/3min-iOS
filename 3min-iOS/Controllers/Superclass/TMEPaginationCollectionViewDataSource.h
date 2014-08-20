//
//  TMEPaginationCollectionViewDataSource.h
//  ThreeMin
//
//  Created by Triệu Khang on 15/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "FPCollectionArrayDataSource.h"
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>

@protocol TMECollectionDataSourceProtocol <NSObject>

- (void)setCellAndFooterClasses:(UICollectionView *)collectionView;

@end

@interface TMEPaginationCollectionViewDataSource : FPCollectionArrayDataSource
<
    CHTCollectionViewDelegateWaterfallLayout,
    TMECollectionDataSourceProtocol
>

@end
