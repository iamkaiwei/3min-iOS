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
@property (assign, nonatomic) NSUInteger page;

@end

@implementation TMEBrowserProductViewModel

- (id)init {
	self = [super init];
	if (self) {
		_page = 1;
	}

	return self;
}

- (NSArray *)arrayItems {
	if (!_arrayItems) {
		_arrayItems = @[];
	}

	return _arrayItems;
}

- (void)getProducts:(void (^)(NSArray *arrProducts))success failure:(void (^)(NSError *error))failure withPage:(NSUInteger)page {

    if (self.page == -1) {
        return;
    }

	[TMEProductsManager getAllProductsWihPage:page
	                           onSuccessBlock: ^(NSArray *arrProducts) {

	    if (arrProducts.count == 0) {
	        self.page = -1;
            return;
		}

	    NSMutableArray *arr = [self.arrayItems mutableCopy];
	    [arr addObjectsFromArray:arrProducts];
	    self.arrayItems = arr;
	    self.page++;

	} failureBlock: ^(NSError *error) {

	}];
}

- (void)getProducts:(void (^)(NSArray *arrProducts))success failure:(void (^)(NSError *error))failure {
	[self getProducts:success failure:failure withPage:self.page];
}

@end
