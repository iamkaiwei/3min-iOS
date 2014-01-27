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

-(void)getAllProductsOnSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSMutableDictionary *params = [@{} mutableCopy];
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
              onSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock
             andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
  NSMutableDictionary *params = [@{} mutableCopy];
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

- (void)likeProductWithProductID:(NSNumber *)productID
                  onSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock
                 andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock{
  NSDictionary *params = @{@"access_token" : [[TMEUserManager sharedInstance] getAccessToken]};
  NSString *path = [NSString stringWithFormat:@"%@%@%@/%@%@", API_SERVER_HOST, API_PREFIX, API_PRODUCTS, productID, API_LIKES];
  [[TMEHTTPClient sharedClient] postPath:path
                              parameters:params
                                 success:^(AFHTTPRequestOperation *operation, id responseObject)
   {
     if (successBlock) {
//       successBlock(responseObject[@"status"]);
     }
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
     if (successBlock) {
       //       successBlock(responseObject[@"status"]);
     }
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
