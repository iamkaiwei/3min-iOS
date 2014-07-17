//
//  TMEApperanceAppDelegateService.m
//  ThreeMin
//
//  Created by Khoa Pham on 7/16/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEApperanceAppDelegateService.h"

@implementation TMEApperanceAppDelegateService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self configureStatusBar];

    return YES;
}

#pragma mark - Helper
- (void)configureStatusBar
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque
                                                animated:NO];

    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation_background"] forBarMetrics:UIBarMetricsDefault];
    }
}

@end
