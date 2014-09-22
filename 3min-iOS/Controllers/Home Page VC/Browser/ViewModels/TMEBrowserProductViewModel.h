//
//  TMEBrowserProductViewModel.h
//  ThreeMin
//
//  Created by Triệu Khang on 15/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMEBrowserProductPaginationCollectionViewDataSource.h"

typedef NS_ENUM(NSUInteger, TMEViewModelState) {
    TMEViewModelStateIntial,
    TMEViewModelStateLoaded,
    TMEViewModelStateLoading,
    TMEViewModelStateLoadingMorePage,
    TMEViewModelStateError,
    TMEViewModelStateNoContent,
    TMEViewModelStateUnknown
};

@interface TMEBrowserProductViewModel : NSObject

@property (copy, nonatomic, readonly) NSArray *arrayItems;

@property (nonatomic, readonly, strong) TMEBrowserProductPaginationCollectionViewDataSource *datasource;

@property (nonatomic, readonly) TMEViewModelState state;

@property (strong, nonatomic) TMECategory *currentCategory;

/**
 *  Reload product from begining
 */

- (void)reload;
- (void)reloadWithFinishBlock:(void (^)(NSError *error))finishBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

- (id)initWithCollectionView:(UICollectionView *)collection __attribute__((objc_designated_initializer));

- (void)getProducts:(void (^)(NSArray *arrProducts))success failure:(void (^)(NSError *error))failure;
- (void)getProducts:(void (^)(NSArray *arrProducts))success failure:(void (^)(NSError *error))failure withPage:(NSUInteger)page;

@end
