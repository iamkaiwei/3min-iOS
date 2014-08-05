//
//  TMECategoryManager.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/4/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMECategoryManager.h"

@implementation TMECategoryManager

OMNIA_SINGLETON_M(sharedManager)

- (void)getAllCategoriesWithSuccess:(TMENetworkManagerArraySuccessBlock)success
                            failure:(TMENetworkManagerFailureBlock)failure
{
    [[TMENetworkManager sharedManager] get:API_CATEGORY params:nil success:^(id responseObject) {
        NSArray *categories = [TMECategory tme_modelsFromJSONResponse:responseObject];
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                success(categories);
            });
        }

    } failure:^(NSError *error) {
        if (failure) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        }
    }];
}

- (void)getTaggableCategoriesWithSuccess:(TMENetworkManagerArraySuccessBlock)success
                                 failure:(TMENetworkManagerFailureBlock)failure
{
    NSString *path = [API_CATEGORY stringByAppendingString:API_CATEGORY_TAGGABLE];

    [[TMENetworkManager sharedManager] get:path params:nil success:^(id responseObject) {
        NSArray *categories = [TMECategory tme_modelsFromJSONResponse:responseObject];
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                success(categories);
            });
        }

    } failure:^(NSError *error) {
        if (failure) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        }
    }];
}

@end
