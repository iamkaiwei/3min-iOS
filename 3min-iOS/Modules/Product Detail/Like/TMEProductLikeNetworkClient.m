//
//  TMEProductLikeNetworkClient.m
//  ThreeMin
//
//  Created by Khoa Pham on 10/6/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductLikeNetworkClient.h"

@implementation TMEProductLikeNetworkClient

- (void)getUsersThatLikeProduct:(TMEProduct *)product
                        success:(TMEArrayBlock)success
                        failure:(TMEErrorBlock)failure
{
    // TODO: Need server API
    NSArray *users = @[ [TMEUserManager sharedManager].loggedUser ];
    if (success) {
        dispatch_async(dispatch_get_main_queue(), ^{
            success(users);
        });
    }
}

@end
