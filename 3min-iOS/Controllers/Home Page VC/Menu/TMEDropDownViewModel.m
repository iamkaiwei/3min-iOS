//
//  TMEDropDownViewModel.m
//  ThreeMin
//
//  Created by Triệu Khang on 28/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEDropDownViewModel.h"

@interface TMEDropDownViewModel()

@property (strong, nonatomic, readwrite) NSArray *arrCategories;

@end

@implementation TMEDropDownViewModel

- (NSArray *)arrCategories {
    if (!_arrCategories) {
        _arrCategories = @[];
    }
    return _arrCategories;
}

- (void)getCategories:(void(^)(NSArray* category, NSError *error))block {

    [[TMECategoryManager sharedManager] getAllCategoriesWithSuccess:^(NSArray *categories) {
        self.arrCategories =  categories;
        block(categories, nil);
    } failure:^(NSError *error) {
        block(nil, error);
    }];
}

@end
