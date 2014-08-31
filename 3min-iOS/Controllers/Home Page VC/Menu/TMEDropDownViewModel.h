//
//  TMEDropDownViewModel.h
//  ThreeMin
//
//  Created by Triệu Khang on 28/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMEDropDownDatasource.h"

@interface TMEDropDownViewModel : NSObject
<
    TMEViewModelDataProtocol
>

@property (strong, nonatomic, readonly) NSMutableArray *arrCategories;
@property (strong, nonatomic, readonly) TMEDropDownDatasource *datasource;
@property (weak, nonatomic) UICollectionView *collectionView;

- (id)initWithCollectionView:(UICollectionView *)collectionView __attribute__((objc_designated_initializer));
- (void)getCategories:(void(^)(NSArray* category, NSError *error))block;

@end
