//
//  TMESearchResultViewModel.h
//  ThreeMin
//
//  Created by Triệu Khang on 7/9/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMEBrowserProductViewModel.h"

@interface TMESearchResultViewModel : NSObject

@property (copy, nonatomic) NSString *searchString;

@property (copy, nonatomic, readonly) NSMutableArray *arrayItems;

@property (nonatomic, readonly, strong) TMEBrowserProductPaginationCollectionViewDataSource *datasource;

@property (nonatomic, readonly) TMEViewModelState state;

- (id)initWithCollectionView:(UICollectionView *)collection;
- (void)searchWithString:(NSString *)key success:(void(^)(NSArray *))successBlock failure:(void(^)(NSError *))failureBlock;

@end
