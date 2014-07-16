//
//  TMEFlurryAppDelegateService.m
//  ThreeMin
//
//  Created by Khoa Pham on 7/16/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEFlurryAppDelegateService.h"
#import <FlurrySDK/Flurry.h>

@implementation TMEFlurryAppDelegateService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Flurry setCrashReportingEnabled:YES];
    [Flurry startSession:FLURRY_API_KEY];

    return YES;
}

@end
