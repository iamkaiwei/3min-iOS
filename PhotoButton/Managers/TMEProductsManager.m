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

-(void)getAllProductsWihPage:(NSInteger)page
              onSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock
             andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSMutableDictionary *params = [@{@"page" : @(page)} mutableCopy];
  [[BaseNetworkManager sharedInstance] getServerListForModelClass:[TMEProduct class]
                                                       withParams:params
                                                        methodAPI:GET_METHOD
                                                         parentId:nil
                                                  withParentClass:nil
                                                          success:^(NSMutableArray *objectsArray)
   {
     
     NSArray *arrProducts = [TMEProduct arrayProductsFromArray:objectsArray];
     
     if (successBlock)
       successBlock(arrProducts);
   } failure:^(NSError *error) {
     if (failureBlock)
       failureBlock(error.code ,error);
   }];
}

-(void)getProductsOfCategory:(TMECategory *)category
                    withPage:(NSInteger)page
              onSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock
             andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSMutableDictionary *params = [@{@"page" : @(page)} mutableCopy];
  [params setObject:category.id forKey:@"category_id"];
  [[BaseNetworkManager sharedInstance] getServerListForModelClass:[TMEProduct class]
                                                       withParams:params
                                                        methodAPI:GET_METHOD
                                                         parentId:nil
                                                  withParentClass:nil
                                                          success:^(NSMutableArray *objectsArray)
   {
     
     NSArray *arrProducts = [TMEProduct arrayProductsFromArray:objectsArray];
     
     if (successBlock)
       successBlock(arrProducts);
   } failure:^(NSError *error) {
     if (failureBlock)
       failureBlock(error.code ,error);
   }];
}

- (void)getSellingProductsOfCurrentUserOnPage:(NSInteger)page
                                 successBlock:(void (^) (NSArray *))successBlock
                                 failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
  NSDictionary *params = @{@"access_token" : [[TMEUserManager sharedInstance] getAccessToken],
                           @"page" : @(page)};
  NSString *path = [NSString stringWithFormat:@"%@%@%@%@", API_SERVER_HOST, API_PREFIX, API_PRODUCTS, API_ME];
  [[TMEHTTPClient sharedClient] getPath:path
                             parameters:params
                                success:^(AFHTTPRequestOperation *operation, id obj)
   {
     NSArray *arrayProduct = [TMEProduct arrayProductsFromArray:obj];
     if(successBlock){
       successBlock(arrayProduct);
     }
   }
                                failure:^(AFHTTPRequestOperation *operation, NSError *error)
   {
     failureBlock(error.code, error);
   }];
  
}

- (void)putSoldOutWithProductID:(NSNumber *)productID
                 onSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock
                andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock{
    NSDictionary *params = @{@"access_token" : [[TMEUserManager sharedInstance] getAccessToken],
                             @"sold_out" : @YES};
    NSString *path = [NSString stringWithFormat:@"%@%@%@/%@", API_SERVER_HOST, API_PREFIX, API_PRODUCTS, productID];
    [[TMEHTTPClient sharedClient] putPath:path
                               parameters:params
                                  success:^(AFHTTPRequestOperation *operation, id obj)
     {

     }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failureBlock(error.code, error);
     }];
}

- (void)getLikedProductOnPage:(NSInteger)page
                 successBlock:(void (^) (NSArray *))successBlock
                 failureBlock:(TMEJSONRequestFailureBlock)failureBlock{
  NSDictionary *params = @{@"access_token" : [[TMEUserManager sharedInstance] getAccessToken],
                           @"page" : @(page)};
  NSString *path = [NSString stringWithFormat:@"%@%@%@%@", API_SERVER_HOST, API_PREFIX, API_PRODUCTS, API_LIKED];
  [[TMEHTTPClient sharedClient] getPath:path
                             parameters:params
                                success:^(AFHTTPRequestOperation *operation, id obj)
   {
     NSArray *arrayProduct = [TMEProduct arrayProductsFromArray:obj];
     if(successBlock){
       successBlock(arrayProduct);
     }
   }
                                failure:^(AFHTTPRequestOperation *operation, NSError *error)
   {
     failureBlock(error.code, error);
   }];
}


- (void)likeProductWithProductID:(NSNumber *)productID
                  onSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock
                 andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock{
  NSDictionary *params = @{@"access_token" : [[TMEUserManager sharedInstance] getAccessToken]};
  NSString *path = [NSString stringWithFormat:@"%@%@%@/%@%@", API_SERVER_HOST, API_PREFIX, API_PRODUCTS, productID, API_LIKES];
  [[TMEHTTPClient sharedClient] postPath:path
                              parameters:params
                                 success:^(AFHTTPRequestOperation *operation, id responseObject)
   {
   }
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error)
   {
     if (failureBlock) {
       failureBlock(error.code, error);
     }
   }];
  
}

- (void)unlikeProductWithProductID:(NSNumber *)productID
                    onSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock
                   andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock{
  NSDictionary *params = @{@"access_token" : [[TMEUserManager sharedInstance] getAccessToken]};
  NSString *path = [NSString stringWithFormat:@"%@%@%@/%@%@", API_SERVER_HOST, API_PREFIX, API_PRODUCTS, productID, API_LIKES];
  [[TMEHTTPClient sharedClient] deletePath:path
                                parameters:params
                                   success:^(AFHTTPRequestOperation *operation, id responseObject)
   {
   }
                                   failure:^(AFHTTPRequestOperation *operation, NSError *error)
   {
     if (failureBlock) {
       failureBlock(error.code, error);
     }
   }];
  
}

#pragma marks - Fake functions to handle products.
- (NSArray *)fakeGetAllStoredProducts
{
  return [TMEProduct MR_findAll];
}

- (NSArray *)fakeGetAllStoredProductsSellByUser:(TMEUser *)user
{
  return [TMEProduct MR_findByAttribute:@"user = " withValue:user];
}

- (NSArray *)fakeGetAllStoredProductsInCategory:(TMECategory *)category
{
  return [TMEProduct MR_findByAttribute:@"category = " withValue:category];
}

#pragma marks - Helper Methods


@end
