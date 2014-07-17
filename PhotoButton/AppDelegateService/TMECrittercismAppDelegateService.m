//
//  TMECrittercismAppDelegateService.m
//  ThreeMin
//
//  Created by Khoa Pham on 7/16/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMECrittercismAppDelegateService.h"

@implementation TMECrittercismAppDelegateService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Crittercism enableWithAppID: @"51f8bef646b7c2316f000007"];

    return YES;
}

@end
