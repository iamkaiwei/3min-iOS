//
//  TMECategoryManager.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/4/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMECategoryManager.h"

@implementation TMECategoryManager

OMNIA_SINGLETON_M(sharedManager)

- (void)getAllCategoriesWithSuccess:(TMENetworkManagerArraySuccessBlock)success
                            failure:(TMENetworkManagerFailureBlock)failure
{
    [[TMENetworkManager sharedManager] getModels:TMECategory.class
                                            path:API_CATEGORY
                                          params:nil
                                         success:success
                                         failure:failure];

}

- (void)getTaggableCategoriesWithSuccess:(TMENetworkManagerArraySuccessBlock)success
                                 failure:(TMENetworkManagerFailureBlock)failure
{
    NSString *path = [API_CATEGORY stringByAppendingString:API_CATEGORY_TAGGABLE];

    [[TMENetworkManager sharedManager] getModels:TMECategory.class
                                            path:path
                                          params:nil
                                         success:success
                                         failure:failure];
}

@end
