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
    [[TMENetworkManager sharedManager] get:API_ACTIVITY
                                    params:nil
                                   success:^(id responseObject)
    {
        NSArray *activities = [TMEActivity tme_modelsFromJSONResponse:responseObject];
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                success(activities);
            });
        }
    } failure:^(NSError *error) {
        if (failure) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        }
    }];
}

@end
