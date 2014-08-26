//
//  TMEErrorCollectionViewDataSource.h
//  ThreeMin
//
//  Created by Triệu Khang on 20/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMEPaginationCollectionViewDataSource.h"

@interface TMEErrorCollectionViewDataSource : NSObject
<
    TMECollectionDataSourceProtocol,
    CHTCollectionViewDelegateWaterfallLayout,
    UICollectionViewDataSource
>

@end
