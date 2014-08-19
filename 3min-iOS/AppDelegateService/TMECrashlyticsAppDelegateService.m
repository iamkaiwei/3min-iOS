//
//  TMECrashlyticsAppDelegateService.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/19/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMECrashlyticsAppDelegateService.h"
#import <CrashlyticsFramework/Crashlytics.h>

@implementation TMECrashlyticsAppDelegateService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Crashlytics startWithAPIKey:@"d64e0062e4657535063ba5de45bd15d45bb451e1"];

    return YES;
}

@end
