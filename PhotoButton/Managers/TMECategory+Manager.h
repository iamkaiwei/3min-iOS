//
//  TMECategory+Manager.h
//  ThreeMin
//
//  Created by Triệu Khang on 26/4/14.
//
//

#import "TMECategory.h"

@interface TMECategory (Manager)

+ (void)getAllCategoriesOnSuccessBlock:(void (^) (NSArray *))successBlock
                       failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

+ (void)getAllCategoriesTaggableOnSuccessBlock:(void (^) (NSArray *))successBlock
                                  failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

@end
