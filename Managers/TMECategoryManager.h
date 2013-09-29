//
//  TMECategoryManager.h
//  PhotoButton
//
//  Created by Hoang Ta on 9/29/13.
//
//

#import "BaseManager.h"

@interface TMECategoryManager : BaseManager

- (void)getAllCategoriesOnSuccessBlock:(TMEJSONRequestSuccessBlock)successBlock
                       andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock;

@end
