//
//  TMEDropDownDatasource.h
//  ThreeMin
//
//  Created by Triệu Khang on 28/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FPCollectionArrayDataSource.h"
#import "TMEDropDownMenuCell.h"
#import "TMEBrowserProductPaginationCollectionViewDataSource.h"

@interface TMEDropDownDatasource : FPCollectionArrayDataSource
<
    UICollectionViewDataSource,
    TMECollectionDataSourceProtocol
>

- (id)initWithItems:(NSArray *)items __attribute__((objc_designated_initializer));
- (CGFloat)totalCellHeight;

@end
