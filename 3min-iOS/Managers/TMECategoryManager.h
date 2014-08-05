//
//  TMECategoryManager.h
//  ThreeMin
//
//  Created by Khoa Pham on 8/4/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEBaseManager.h"

@interface TMECategoryManager : TMEBaseManager

OMNIA_SINGLETON_H(sharedManager)

- (void)getAllCategoriesWithSuccess:(TMENetworkManagerArraySuccessBlock)success
                            failure:(TMENetworkManagerFailureBlock)failure;

- (void)getTaggableCategoriesWithSuccess:(TMENetworkManagerArraySuccessBlock)success
                                 failure:(TMENetworkManagerFailureBlock)failure;

@end
