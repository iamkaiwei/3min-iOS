//
//  TMEBrowserProductViewModel.h
//  ThreeMin
//
//  Created by Triệu Khang on 15/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMEPaginationCollectionViewDataSource.h"

typedef NS_ENUM(NSUInteger, TMEViewModelState) {
    TMEViewModelStateLoading,
    TMEViewModelStateLoadingMorePage,
    TMEViewModelStateError,
    TMEViewModelStateNoContent,
    TMEViewModelStateUnknown
};

@interface TMEBrowserProductViewModel : NSObject

@property (copy, nonatomic, readonly) NSArray *arrayItems;

@property (nonatomic, readonly) TMEPaginationCollectionViewDataSource *datasource;

@property (nonatomic, readonly) TMEViewModelState state;

- (id)initWithCollectionView:(UICollectionView *)collection;

- (void)getProducts:(void (^)(NSArray *arrProducts))success failure:(void (^)(NSError *error))failure;
- (void)getProducts:(void (^)(NSArray *arrProducts))success failure:(void (^)(NSError *error))failure withPage:(NSUInteger)page;

@end
