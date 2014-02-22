//
//  TMEProductsManager.h
//  PhotoButton
//
//  Created by Triệu Khang on 23/9/13.
//
//

#import "TMEHTTPClient.h"

@interface TMEProductsManager : BaseManager

- (NSArray *)fakeGetAllStoredProducts;
- (void)getAllProductsOnSuccessBlock:(void (^)(NSArray *arrayProducts))successBlock
                     andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock;

-(void)getProductsOfCategory:(TMECategory *)category
              onSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock
             andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock;

- (void)getSellingProductsOfCurrentUserOnPage:(NSInteger)page successBlock:(void (^) (NSArray *arrayProducts))successBlock
                                 failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

- (void)getLikedProductOnPage:(NSInteger)page
                 successBlock:(void (^) (NSArray *))successBlock
                 failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

- (void)likeProductWithProductID:(NSNumber *)productID
                  onSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock
                 andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock;

- (void)unlikeProductWithProductID:(NSNumber *)productID
                    onSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock
                   andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock;

@end
