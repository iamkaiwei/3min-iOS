//
//  TMEActivityManager.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/4/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEActivityManager.h"
#import "TMEActivity.h"

@implementation TMEActivityManager

OMNIA_SINGLETON_M(sharedManager)

- (void)getActivitiesWithSuccess:(TMENetworkManagerArraySuccessBlock)success
                         failure:(TMENetworkManagerFailureBlock)failure
{
    [[TMENetworkManager sharedManager] getModels:TMEActivity.class
                                            path:API_ACTIVITY
                                          params:nil
                                         success:success
                                         failure:failure];

}

@end
