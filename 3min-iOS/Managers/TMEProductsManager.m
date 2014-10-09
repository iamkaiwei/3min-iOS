//
//  TMEProductsManager.m
//  PhotoButton
//
//  Created by Triệu Khang on 23/9/13.
//
//

#import "TMEProductsManager.h"

@implementation TMEProductsManager


+ (void)getAllProductsWihPage:(NSInteger)page
               onSuccessBlock:(void (^) (NSArray *))successBlock
                 failureBlock:(TMENetworkManagerFailureBlock)failureBlock
{
    NSDictionary *params = @{@"page" : @(page)};

    [[TMENetworkManager sharedManager] getModels:[TMEProduct class]
                                            path:API_PRODUCTS
                                          params:params
                                         success:successBlock
                                         failure:failureBlock];
}

+ (void)getProductsOfCategory:(TMECategory *)category
                     withPage:(NSInteger)page
               onSuccessBlock:(void (^) (NSArray *))successBlock
                 failureBlock:(TMENetworkManagerFailureBlock)failureBlock
{
    NSDictionary *params = @{@"page" : @(page),
                             @"category_id" : category.categoryId};

    [[TMENetworkManager sharedManager] getModels:[TMEProduct class]
                                            path:API_PRODUCTS
                                          params:params
                                         success:successBlock
                                         failure:failureBlock];
}

+ (void)getPopularProductsWithPage:(NSInteger)page
                    onSuccessBlock:(void (^) (NSArray *))successBlock
                      failureBlock:(TMENetworkManagerFailureBlock)failureBlock
{
    NSDictionary *params = @{@"page" : @(page)};
    NSString *path = [NSString stringWithFormat:@"%@%@", API_PRODUCTS, API_POPULAR];

    [[TMENetworkManager sharedManager] getModels:[TMEProduct class]
                                            path:path
                                          params:params
                                         success:successBlock
                                         failure:failureBlock];
}

+ (void)getSellingProductsOfCurrentUserOnPage:(NSInteger)page
                                 successBlock:(void (^) (NSArray *))successBlock
                                 failureBlock:(TMENetworkManagerFailureBlock)failureBlock
{
    NSDictionary *params = @{@"page" : @(page)};
    NSString *path = [NSString stringWithFormat:@"%@%@", API_PRODUCTS, API_ME];

    [[TMENetworkManager sharedManager] getModels:[TMEProduct class]
                                            path:path
                                          params:params
                                         success:successBlock
                                         failure:failureBlock];
}

+ (void)putSoldOutWithProductID:(NSNumber *)productID
                 onSuccessBlock:(void (^) (NSArray *))successBlock
                   failureBlock:(TMENetworkManagerFailureBlock)failureBlock{
    NSDictionary *params = @{@"sold_out" : @YES};
    NSString *path = [NSString stringWithFormat:@"%@/%@", API_PRODUCTS, productID];

    [[TMENetworkManager sharedManager] put:path params:params success:^(id responseObject) {
        if (successBlock) {
            NSArray *products = [TMEProduct tme_modelsFromJSONResponse:responseObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                successBlock(products);
            });
        }
    } failure:^(NSError *error) {
        if (failureBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failureBlock(error);
            });
        }
    }];
}

+ (void)getLikedProductOnPage:(NSInteger)page
                 successBlock:(void (^) (NSArray *))successBlock
                 failureBlock:(TMENetworkManagerFailureBlock)failureBlock{
    NSDictionary *params = @{@"page" : @(page)};
    NSString *path = [NSString stringWithFormat:@"%@%@", API_PRODUCTS, @"likes"];

    [[TMENetworkManager sharedManager] getModels:[TMEProduct class]
                                            path:path
                                          params:params
                                         success:successBlock
                                         failure:failureBlock];
}


+ (void)likeProductWithProductID:(NSNumber *)productID
                  onSuccessBlock:(void (^) (NSString *))successBlock
                    failureBlock:(TMENetworkManagerFailureBlock)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@", API_PRODUCTS, productID, @"likes"];

    [[TMENetworkManager sharedManager] post:path params:nil success:^(id responseObject) {
        if (successBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                successBlock(responseObject[@"status"]);
            });
        }
    } failure:^(NSError *error) {
        if (failureBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failureBlock(error);
            });
        }
    }];
}

+ (void)unlikeProductWithProductID:(NSNumber *)productID
                    onSuccessBlock:(void (^) (NSString *))successBlock
                      failureBlock:(TMENetworkManagerFailureBlock)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@", API_PRODUCTS, productID, @"likes"];

    [[TMENetworkManager sharedManager] post:path params:nil success:^(id responseObject) {
        if (successBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                successBlock(responseObject[@"status"]);
            });
        }
    } failure:^(NSError *error) {
        if (failureBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failureBlock(error);
            });
        }
    }];
}

@end
