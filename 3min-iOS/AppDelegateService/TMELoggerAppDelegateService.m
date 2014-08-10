//
//  TMELoggerAppDelegateService.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/10/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMELoggerAppDelegateService.h"
#import <CocoaLumberjack/DDASLLogger.h>
#import <CocoaLumberjack/DDTTYLogger.h>

@implementation TMELoggerAppDelegateService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];

    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    return YES;
}

@end
