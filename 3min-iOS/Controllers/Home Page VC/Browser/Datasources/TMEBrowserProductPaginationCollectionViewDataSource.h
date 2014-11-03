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

@interface TMEBrowserProductPaginationCollectionViewDataSource : FPCollectionArrayDataSource
<
    CHTCollectionViewDelegateWaterfallLayout,
    TMECollectionDataSourceProtocol
>

@property (nonatomic, weak) UIViewController *ownerViewController;

@end
