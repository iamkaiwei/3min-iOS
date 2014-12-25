//
//  TMEProductsManager.h
//  PhotoButton
//
//  Created by Triệu Khang on 23/9/13.
//
//

#import "TMECategory.h"

@interface TMEProductsManager : TMEBaseManager

+ (void)getAllProductsWihPage:(NSInteger)page
               onSuccessBlock:(void (^)(NSArray *))successBlock
                 failureBlock:(TMENetworkManagerFailureBlock)failureBlock;

+ (void)getProductsFromUserID:(NSNumber *)userID
               onSuccessBlock:(void (^)(NSArray *))successBlock
                 failureBlock:(TMENetworkManagerFailureBlock)failureBlock;

+ (void)getProductsOfCategory:(TMECategory *)category
                     withPage:(NSInteger)page
               onSuccessBlock:(void (^) (NSArray *))successBlock
                 failureBlock:(TMENetworkManagerFailureBlock)failureBlock;

+ (void)getPopularProductsWithPage:(NSInteger)page
                    onSuccessBlock:(void (^) (NSArray *))successBlock
                      failureBlock:(TMENetworkManagerFailureBlock)failureBlock;

+ (void)getSellingProductsOfCurrentUserOnPage:(NSInteger)page
                                 successBlock:(void (^) (NSArray *))successBlock
                                 failureBlock:(TMENetworkManagerFailureBlock)failureBlock;

+ (void)putSoldOutWithProductID:(NSNumber *)productID
                 onSuccessBlock:(void (^) (NSArray *))successBlock
                   failureBlock:(TMENetworkManagerFailureBlock)failureBlock;

+ (void)getLikedProductOnPage:(NSInteger)page
                 successBlock:(void (^) (NSArray *))successBlock
                 failureBlock:(TMENetworkManagerFailureBlock)failureBlock;

+ (void)likeProductWithProductID:(NSNumber *)productID
                  onSuccessBlock:(void (^) (NSString *))successBlock
                    failureBlock:(TMENetworkManagerFailureBlock)failureBlock;

+ (void)unlikeProductWithProductID:(NSNumber *)productID
                    onSuccessBlock:(void (^) (NSString *))successBlock
                      failureBlock:(TMENetworkManagerFailureBlock)failureBlock;

+ (void)getOwnProductsWihPage:(NSInteger)page
               onSuccessBlock:(void (^) (NSArray *))successBlock
                 failureBlock:(TMENetworkManagerFailureBlock)failureBlock;

+ (void)createProduct:(TMEProduct *)product
               images:(NSArray *)images
              success:(void (^)(TMEProduct *responsedProduct))success
              failure:(TMENetworkManagerFailureBlock)failure;

+ (void)updateProduct:(TMEProduct *)product
               images:(NSArray *)images
              success:(void (^)(TMEProduct *responsedProduct))success
              failure:(TMENetworkManagerFailureBlock)failure;

+ (void)deleteProductListing:(NSNumber *)productID
                     success:(TMESuccessBlock)success
                     failure:(TMEFailureBlock)failure;

@end
