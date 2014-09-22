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
    [self configureNavigationBar];

    return YES;
}

#pragma mark - Helper
- (void)configureStatusBar
{
    if (IS_IOS7_OR_ABOVE) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault
                                                    animated:NO];
    } else {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation_background"] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)configureNavigationBar
{
    NSDictionary *titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                          };
    [[UINavigationBar appearance] setTitleTextAttributes:titleTextAttributes];
}

@end
