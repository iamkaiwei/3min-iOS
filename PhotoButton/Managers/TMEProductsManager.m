//
//  TMEProductsManager.m
//  PhotoButton
//
//  Created by Triệu Khang on 23/9/13.
//
//

#import "TMEProductsManager.h"

@implementation TMEProductsManager

SINGLETON_MACRO

+ (void)getAllProductsWihPage:(NSInteger)page
               onSuccessBlock:(void (^) (NSArray *))successBlock
                 failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSDictionary *params = @{@"page" : @(page)};

    [[AFHTTPRequestOperationManager tme_manager] GET:API_PRODUCTS parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if (successBlock){
             NSArray *arrProducts = [TMEProduct arrayProductsFromArray:responseObject];
             successBlock(arrProducts);
         }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failureBlock)
             failureBlock(error.code ,error);
    }];
}

+ (void)getProductsOfCategory:(TMECategory *)category
                     withPage:(NSInteger)page
               onSuccessBlock:(void (^) (NSArray *))successBlock
                 failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSDictionary *params = @{@"page" : @(page),
                             @"category_id" : category.id};

    [[AFHTTPRequestOperationManager tme_manager] GET:API_PRODUCTS parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if (successBlock){
             NSArray *arrProducts = [TMEProduct arrayProductsFromArray:responseObject];
             successBlock(arrProducts);
         }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failureBlock)
             failureBlock(error.code ,error);
    }];
}

+ (void)getPopularProductsWithPage:(NSInteger)page
                    onSuccessBlock:(void (^) (NSArray *))successBlock
                      failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSDictionary *params = @{@"page" : @(page)};
    NSString *path = [NSString stringWithFormat:@"%@%@", API_PRODUCTS, API_POPULAR];

    [[AFHTTPRequestOperationManager tme_manager] GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if (successBlock){
             NSArray *arrProducts = [TMEProduct arrayProductsFromArray:responseObject];
             successBlock(arrProducts);
         }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failureBlock)
             failureBlock(error.code ,error);
    }];
}

+ (void)getSellingProductsOfCurrentUserOnPage:(NSInteger)page
                                 successBlock:(void (^) (NSArray *))successBlock
                                 failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSDictionary *params = @{@"page" : @(page)};
    NSString *path = [NSString stringWithFormat:@"%@%@", API_PRODUCTS, API_ME];

    [[AFHTTPRequestOperationManager tme_manager] GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if (successBlock){
             NSArray *arrProducts = [TMEProduct arrayProductsFromArray:responseObject];
             successBlock(arrProducts);
         }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failureBlock)
             failureBlock(error.code ,error);
    }];
}

+ (void)putSoldOutWithProductID:(NSNumber *)productID
                 onSuccessBlock:(void (^) (NSArray *))successBlock
                   failureBlock:(TMEJSONRequestFailureBlock)failureBlock{
    NSDictionary *params = @{@"sold_out" : @YES};
    NSString *path = [NSString stringWithFormat:@"%@/%@", API_PRODUCTS, productID];

    [[AFHTTPRequestOperationManager tme_manager] PUT:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if (successBlock){
             NSArray *arrProducts = [TMEProduct arrayProductsFromArray:responseObject];
             successBlock(arrProducts);
         }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failureBlock)
             failureBlock(error.code ,error);
    }];
}

+ (void)getLikedProductOnPage:(NSInteger)page
                 successBlock:(void (^) (NSArray *))successBlock
                 failureBlock:(TMEJSONRequestFailureBlock)failureBlock{
    NSDictionary *params = @{@"page" : @(page)};
    NSString *path = [NSString stringWithFormat:@"%@%@", API_PRODUCTS, API_LIKED];

    [[AFHTTPRequestOperationManager tme_manager] GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if (successBlock){
             NSArray *arrProducts = [TMEProduct arrayProductsFromArray:responseObject];
             successBlock(arrProducts);
         }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failureBlock)
             failureBlock(error.code ,error);
    }];
}


+ (void)likeProductWithProductID:(NSNumber *)productID
                  onSuccessBlock:(void (^) (NSString *))successBlock
                    failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"%@/%@%@", API_PRODUCTS, productID, API_LIKES];

    [[AFHTTPRequestOperationManager tme_manager] POST:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if (successBlock){
             successBlock(responseObject[@"status"]);
         }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failureBlock)
             failureBlock(error.code ,error);
    }];
}

+ (void)unlikeProductWithProductID:(NSNumber *)productID
                    onSuccessBlock:(void (^) (NSString *))successBlock
                      failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"%@/%@%@", API_PRODUCTS, productID, API_LIKES];

    [[AFHTTPRequestOperationManager tme_manager] POST:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if (successBlock){
             successBlock(responseObject[@"status"]);
         }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failureBlock)
             failureBlock(error.code ,error);
    }];
}

@end
