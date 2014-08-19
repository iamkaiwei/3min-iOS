//
//  TMEDeviceManagerAppDelegateService.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/18/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEDeviceManagerAppDelegateService.h"
#import "TMEDeviceManager.h"

@implementation TMEDeviceManagerAppDelegateService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[TMEDeviceManager sharedManager] load];

    return YES;
}

@end
