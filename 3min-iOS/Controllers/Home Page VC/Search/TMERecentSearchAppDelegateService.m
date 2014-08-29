//
//  TMERecentSearchAppDelegateService.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/29/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMERecentSearchAppDelegateService.h"
#import "TMERecentSearchManager.h"

@implementation TMERecentSearchAppDelegateService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[TMERecentSearchManager sharedManager] load];

    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[TMERecentSearchManager sharedManager] save];
}

@end
