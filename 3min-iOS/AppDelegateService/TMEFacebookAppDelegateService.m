//
//  TMEFacebookAppDelegateService.m
//  ThreeMin
//
//  Created by Khoa Pham on 7/16/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEFacebookAppDelegateService.h"
#import "TMEFacebookManager.h"

@interface TMEFacebookAppDelegateService ()

@end

@implementation TMEFacebookAppDelegateService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[TMEFacebookManager sharedManager] setup];

    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[TMEFacebookManager sharedManager] handleDidBecomeActive];
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [[TMEFacebookManager sharedManager] handleOpenURL:url sourceApplication:sourceApplication];
}

@end
