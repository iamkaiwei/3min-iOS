//
//  TMEProductCommentNetworkClient.m
//  ThreeMin
//
//  Created by Khoa Pham on 10/6/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductCommentNetworkClient.h"
#import "TMEProductComment.h"

@implementation TMEProductCommentNetworkClient

- (void)getCommentsForProduct:(TMEProduct *)product
                      success:(TMEArrayBlock)success
                      failure:(TMEErrorBlock)failure
{
    NSString *fullPath = [self commentAPIPathForProduct:product];

    [[TMENetworkManager sharedManager] get:fullPath
                                    params:nil success:^(id responseObject)
    {
        NSArray *productComments = [self productCommentsFromResponse:responseObject];
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                success(productComments);
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

- (void)createCommentForProduct:(TMEProduct *)product
                        content:(NSString *)content
                     completion:(TMEBooleanBlock)completion
{
    NSString *fullPath = [self commentAPIPathForProduct:product];

    NSDictionary *params = @{@"comment": @{@"content": content}
                             };

    [[TMENetworkManager sharedManager] post:fullPath
                                     params:params
                                    success:^(id responseObject)
    {
        BOOL succeeded = [responseObject[@"status"] isEqualToString:kSuccess];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(succeeded);
            });
        }
    } failure:^(NSError *error) {
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(NO);
            });
        }
    }];
}

#pragma mark - Helper
- (NSString *)commentAPIPathForProduct:(TMEProduct *)product
{
    NSString *path = NSStringf(@"/api/v1/products/%@/comments.json", product.productID.stringValue);
    return NSStringf(@"%@%@", API_BASE_URL, path);
}

- (NSArray *)productCommentsFromResponse:(id)response
{
    if (![response isKindOfClass:[NSArray class]]) {
        return nil;
    }

    return [TMEProductComment tme_modelsFromJSONResponse:response];
}

@end
