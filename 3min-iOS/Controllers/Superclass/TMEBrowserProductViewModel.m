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

@property (nonatomic, readwrite) TMEViewModelState state;

@property (nonatomic, readwrite) TMEPaginationCollectionViewDataSource *datasource;

@property (assign, nonatomic) NSUInteger page;

@end

@implementation TMEBrowserProductViewModel

- (id)init {
	self = [super init];
	if (self) {
		_page = 1;
		self.state = TMEViewModelStateLoading;
	}

	return self;
}

- (id)initWithCollectionView:(UICollectionView *)collection {
    self = [super init];
    if (self) {
    }
    return self;
}

- (id <UICollectionViewDataSource> )dataSourceFactory:(TMEViewModelState)state {
#warning NEED REFACTOR
	return [[TMEPaginationCollectionViewDataSource alloc] initWithItems:self.arrayItems identifierParserBlock:nil configureCellBlock:nil];
//	if (state == TMEViewModelStateLoadingMorePage) {
//		return [[TMEPaginationCollectionViewDataSource alloc] init];
//	}
//
//	return [[TMEPaginationCollectionViewDataSource alloc] init];
}

- (void)setState:(TMEViewModelState)state {
	_state = state;
	self.datasource = [self dataSourceFactory:state];
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

	    self.state = TMEViewModelStateLoadingMorePage;
	} failureBlock: ^(NSError *error) {
	    self.state = TMEViewModelStateError;
	}];
}

- (void)getProducts:(void (^)(NSArray *arrProducts))success failure:(void (^)(NSError *error))failure {
	[self getProducts:success failure:failure withPage:self.page];
}

@end
