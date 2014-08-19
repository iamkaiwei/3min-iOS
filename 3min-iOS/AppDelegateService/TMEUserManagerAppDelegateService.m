//
//  TMEUserManagerAppDelegateService.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/19/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEUserManagerAppDelegateService.h"

@implementation TMEUserManagerAppDelegateService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[TMEUserManager sharedManager] load];

    return YES;
}

@end
