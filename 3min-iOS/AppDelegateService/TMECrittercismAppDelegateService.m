//
//  TMECrittercismAppDelegateService.m
//  ThreeMin
//
//  Created by Khoa Pham on 7/16/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMECrittercismAppDelegateService.h"
#import <CrittercismSDK/Crittercism.h>

@implementation TMECrittercismAppDelegateService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Crittercism enableWithAppID: @"53c7ff2abb94753c13000001"];

    return YES;
}

@end
