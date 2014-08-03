//
//  TMEReachabilityAppDelegateService.m
//  ThreeMin
//
//  Created by Khoa Pham on 7/16/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEReachabilityAppDelegateService.h"
#import "TMEReachabilityManager.h"

@implementation TMEReachabilityAppDelegateService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[TMEReachabilityManager sharedInstance] setup];

    return YES;
}

@end
