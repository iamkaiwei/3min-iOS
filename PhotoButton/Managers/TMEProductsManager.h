//
//  TMEProductsManager.h
//  PhotoButton
//
//  Created by Triệu Khang on 23/9/13.
//
//

#import "TMEHTTPClient.h"
#import "TMECategory.h"

@interface TMEProductsManager : BaseManager

+ (void)getAllProductsWihPage:(NSInteger)page
               onSuccessBlock:(void (^)(NSArray *))successBlock
                 failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

+ (void)getProductsOfCategory:(TMECategory *)category
                     withPage:(NSInteger)page
               onSuccessBlock:(void (^) (NSArray *))successBlock
                 failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

+ (void)getPopularProductsWithPage:(NSInteger)page
                    onSuccessBlock:(void (^) (NSArray *))successBlock
                      failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

+ (void)getSellingProductsOfCurrentUserOnPage:(NSInteger)page
                                 successBlock:(void (^) (NSArray *))successBlock
                                 failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

+ (void)putSoldOutWithProductID:(NSNumber *)productID
                 onSuccessBlock:(void (^) (NSArray *))successBlock
                   failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

+ (void)getLikedProductOnPage:(NSInteger)page
                 successBlock:(void (^) (NSArray *))successBlock
                 failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

+ (void)likeProductWithProductID:(NSNumber *)productID
                  onSuccessBlock:(void (^) (NSString *))successBlock
                    failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

+ (void)unlikeProductWithProductID:(NSNumber *)productID
                    onSuccessBlock:(void (^) (NSString *))successBlock
                      failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

@end
