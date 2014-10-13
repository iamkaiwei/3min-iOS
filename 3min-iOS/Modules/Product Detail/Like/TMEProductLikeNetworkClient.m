//
//  TMEProductLikeNetworkClient.m
//  ThreeMin
//
//  Created by Khoa Pham on 10/6/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductLikeNetworkClient.h"

@implementation TMEProductLikeNetworkClient

- (void)getUsersThatLikeProduct:(TMEProduct *)product
                        success:(TMEArrayBlock)success
                        failure:(TMEErrorBlock)failure
{
    NSString *fullPath = [self likeAPIPathForProduct:product];

    [[TMENetworkManager sharedManager] get:fullPath
                                    params:nil success:^(id responseObject)
     {
         NSArray *users = [TMEUser tme_modelsFromJSONResponse:responseObject];
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(users);
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

#pragma mark - Helper
- (NSString *)likeAPIPathForProduct:(TMEProduct *)product
{
    NSString *path = NSStringf(@"/api/v1/products/%@/likes", product.productID.stringValue);
    return NSStringf(@"%@%@", API_BASE_URL, path);
}

@end
