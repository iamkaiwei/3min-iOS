//
//  TMESearchNetworkClient.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/29/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMESearchNetworkClient.h"

@implementation TMESearchNetworkClient

- (void)search:(NSString *)searchText sucess:(TMEArraySuccessBlock)success failure:(TMEFailureBlock)failure {
	[TMEProductsManager getAllProductsWihPage:1 onSuccessBlock: ^(NSArray *arrItems) {
	    if (success) {
	        success(arrItems);
		}
	} failureBlock: ^(NSError *error) {

	}];
}

@end
