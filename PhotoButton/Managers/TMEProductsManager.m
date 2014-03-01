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
              onSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock
                failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSDictionary *params = @{@"page" : @(page)};
    [[BaseNetworkManager sharedInstance] getServerListForModelClass:[TMEProduct class]
                                                         withParams:params
                                                          methodAPI:GET_METHOD
                                                           parentId:nil
                                                    withParentClass:nil
                                                            success:^(NSMutableArray *objectsArray)
     {
         if (successBlock){
             NSArray *arrProducts = [TMEProduct arrayProductsFromArray:objectsArray];
             successBlock(arrProducts);
         }
     }
                                                            failure:^(NSError *error)
     {
         if (failureBlock)
             failureBlock(error.code ,error);
     }];
}

+ (void)getProductsOfCategory:(TMECategory *)category
                    withPage:(NSInteger)page
              onSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock
                failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSDictionary *params = @{@"page" : @(page),
                             @"category_id" : category.id};
    
    [[BaseNetworkManager sharedInstance] getServerListForModelClass:[TMEProduct class]
                                                         withParams:params
                                                          methodAPI:GET_METHOD
                                                           parentId:nil
                                                    withParentClass:nil
                                                            success:^(NSMutableArray *objectsArray)
     {
         if (successBlock){
             NSArray *arrProducts = [TMEProduct arrayProductsFromArray:objectsArray];
             successBlock(arrProducts);
         }
     }
                                                            failure:^(NSError *error)
     {
         if (failureBlock)
             failureBlock(error.code ,error);
     }];
}

+ (void)getPopularProductsWithPage:(NSInteger)page
                    onSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock
                      failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSDictionary *params = @{@"page" : @(page)};
    NSString *path = [NSString stringWithFormat:@"%@%@", API_PRODUCTS, API_POPULAR];
    
    [[BaseNetworkManager sharedInstance] sendRequestForPath:path
                                                 parameters:params
                                                     method:GET_METHOD
                                                    success:^(NSHTTPURLResponse *response, id responseObject)
     {
         if (successBlock){
             NSArray *arrProducts = [TMEProduct arrayProductsFromArray:responseObject];
             successBlock(arrProducts);
         }
     }
                                                    failure:^(NSError *error)
     {
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
    
    [[BaseNetworkManager sharedInstance] sendRequestForPath:path
                                                 parameters:params
                                                     method:GET_METHOD
                                                    success:^(NSHTTPURLResponse *response, id responseObject)
     {
         if (successBlock){
             NSArray *arrProducts = [TMEProduct arrayProductsFromArray:responseObject];
             successBlock(arrProducts);
         }
     }
                                                    failure:^(NSError *error)
     {
         if (failureBlock)
             failureBlock(error.code ,error);
     }];
}

+ (void)putSoldOutWithProductID:(NSNumber *)productID
                 onSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock
                   failureBlock:(TMEJSONRequestFailureBlock)failureBlock{
    NSDictionary *params = @{@"sold_out" : @YES};
    NSString *path = [NSString stringWithFormat:@"%@/%@", API_PRODUCTS, productID];
    
    [[BaseNetworkManager sharedInstance] sendRequestForPath:path
                                                 parameters:params
                                                     method:PUT_METHOD
                                                    success:^(NSHTTPURLResponse *response, id responseObject)
     {
         if (successBlock){
             successBlock(nil);
         }
     }
                                                    failure:^(NSError *error)
     {
         if (failureBlock)
             failureBlock(error.code ,error);
     }];
}

+ (void)getLikedProductOnPage:(NSInteger)page
                 successBlock:(void (^) (NSArray *))successBlock
                 failureBlock:(TMEJSONRequestFailureBlock)failureBlock{
    NSDictionary *params = @{@"page" : @(page)};
    NSString *path = [NSString stringWithFormat:@"%@%@", API_PRODUCTS, API_LIKED];
    
    [[BaseNetworkManager sharedInstance] sendRequestForPath:path
                                                 parameters:params
                                                     method:GET_METHOD
                                                    success:^(NSHTTPURLResponse *response, id responseObject)
     {
         if(successBlock){
             NSArray *arrayProduct = [TMEProduct arrayProductsFromArray:responseObject];
             successBlock(arrayProduct);
         }
     }
                                                    failure:^(NSError *error)
     {
         if (failureBlock) {
             failureBlock(error.code, error);
         }
     }];
}


+ (void)likeProductWithProductID:(NSNumber *)productID
                  onSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock
                    failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"%@/%@%@", API_PRODUCTS, productID, API_LIKES];
    [[BaseNetworkManager sharedInstance] sendRequestForPath:path
                                                 parameters:nil
                                                     method:POST_METHOD
                                                    success:^(NSHTTPURLResponse *response, id responseObject)
     {
         if (successBlock) {
             successBlock(nil);
         }
     }
                                                    failure:^(NSError *error)
     {
         if (failureBlock) {
             failureBlock(error.code, error);
         }
     }];
    
}

+ (void)unlikeProductWithProductID:(NSNumber *)productID
                    onSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock
                      failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"%@/%@%@", API_PRODUCTS, productID, API_LIKES];
    [[BaseNetworkManager sharedInstance] sendRequestForPath:path
                                                 parameters:nil
                                                     method:DELETE_METHOD
                                                    success:^(NSHTTPURLResponse *response, id responseObject)
    {
        if (successBlock) {
            successBlock(nil);
        }
    }
                                                    failure:^(NSError *error)
    {
        if (failureBlock) {
            failureBlock(error.code, error);
        }
    }];
}

@end
