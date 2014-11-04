//
//  TMEBrowserProductLoadingOperation.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEBrowserProductLoadingOperation.h"
#import "TMEProduct+ProductCellHeight.h"

@interface TMEBrowserProductLoadingOperation ()

@property (assign, nonatomic) NSUInteger page;
@property (assign, nonatomic) NSUInteger userID;

@property (strong, nonatomic) NSArray *dataPage;

@end

@implementation TMEBrowserProductLoadingOperation

- (instancetype)initWithCategory:(TMECategory *)category andPage:(NSUInteger)page {
	self = [super init];
	if (self) {
		_currentCategory = category;
		_page = page;
	}

	return self;
}

- (void)loadData:(void (^)(NSArray *, NSError *))finishBlock {
	__weak typeof(self) weakSelf = self;

	void (^successBlock)(NSArray *) = ^(NSArray *arrProducts) {
		NSMutableArray *arr = [self.dataPage mutableCopy];
		[arr addObjectsFromArray:arrProducts];
		weakSelf.dataPage = arr;

		// caculate the height
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void) {
		    [arrProducts enumerateObjectsUsingBlock: ^(TMEProduct *product, NSUInteger idx, BOOL *stop) {
		        [product productCellHeight];
			}];
		    dispatch_async(dispatch_get_main_queue(), ^(void) {
		        if (finishBlock) {
		            finishBlock(arrProducts, nil);
				}
			});
		});
	};

	if (self.currentCategory) {
		[TMEProductsManager getProductsOfCategory:self.currentCategory
		                                 withPage:self.page
		                           onSuccessBlock: ^(NSArray *arrProducts) {
		    weakSelf.dataPage = arrProducts;
		    successBlock(arrProducts);
		} failureBlock: ^(NSError *error) {
		    finishBlock(nil, error);
		}];
		return;
	}

	[TMEProductsManager getAllProductsWihPage:self.page
	                           onSuccessBlock: ^(NSArray *arrProducts) {
	    weakSelf.dataPage = arrProducts;
	    successBlock(arrProducts);
	} failureBlock: ^(NSError *error) {
	    finishBlock(nil, error);
	}];
}

@end
