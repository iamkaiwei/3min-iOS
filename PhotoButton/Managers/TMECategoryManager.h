//
//  TMECategoryManager.h
//  PhotoButton
//
//  Created by Hoang Ta on 9/29/13.
//
//

#import "BaseManager.h"

@interface TMECategoryManager : BaseManager

+ (void)getAllCategoriesOnSuccessBlock:(void (^) (NSArray *arrayCategories))successBlock
                       failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

@end
