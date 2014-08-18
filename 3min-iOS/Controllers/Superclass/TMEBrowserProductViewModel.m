//
//  TMEBrowserProductViewModel.m
//  ThreeMin
//
//  Created by Triệu Khang on 15/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEBrowserProductViewModel.h"

@interface TMEBrowserProductViewModel ()

@property (copy, nonatomic, readwrite) NSArray *arrayItems;

@end

@implementation TMEBrowserProductViewModel

- (NSArray *)arrayItems {
    if (!_arrayItems) {
        _arrayItems = @[];
    }

    return _arrayItems;
}

- (void)getProducts:(void (^)(NSArray *arrProducts))success failure:(void (^)(NSError *error))failure {
	[TMEProductsManager getAllProductsWihPage:1
	                           onSuccessBlock: ^(NSArray *arrProducts) {
	    self.arrayItems = arrProducts;
	} failureBlock: ^(NSError *error) {
	}];
}

@end
