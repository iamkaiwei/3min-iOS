//
//  TMEMyItemLoadingOperation.m
//  ThreeMin
//
//  Created by Triệu Khang on 5/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEMyItemLoadingOperation.h"
#import "TMEProduct+ProductCellHeight.h"

@interface TMEMyItemLoadingOperation ()

@property (assign, nonatomic) NSUInteger page;
@property (strong, nonatomic) NSArray *dataPage;

@end

@implementation TMEMyItemLoadingOperation

- (instancetype)initWithPage:(NSUInteger)page {
	self = [super init];
	if (self) {
		_page = page;
	}

	return self;
}

- (void)loadData:(void (^)(NSArray *, NSError *))finishBlock {
	__weak typeof(self) weakSelf = self;

	void (^successBlock)(NSArray *) = ^(NSArray *arrProducts) {
		NSMutableArray *arr = [weakSelf.dataPage mutableCopy];
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

	[TMEProductsManager getOwnProductsWihPage:self.page
	                           onSuccessBlock: ^(NSArray *arrProducts) {
	    weakSelf.dataPage = arrProducts;
	    dispatch_async(dispatch_get_main_queue(), ^{
	        successBlock(arrProducts);
		});
	} failureBlock: ^(NSError *error) {
	    dispatch_async(dispatch_get_main_queue(), ^{
	        finishBlock(nil, error);
		});
	}];
}

@end
