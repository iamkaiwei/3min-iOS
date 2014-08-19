//
//  AppDelegate.m
//  PhotoButton
//
//  Created by Triệu Khang on 08/09/13.
//  Copyright (c) 2013 hasBrain. All rights reserved.
//

#import "AppDelegate.h"
#import "TMERootAppDelegateService.h"
#import "TMEPushNotificationAppDelegateService.h"
#import "TMEFacebookAppDelegateService.h"
#import "TMECrittercismAppDelegateService.h"
#import "TMECoreDataAppDelegateService.h"
#import "TMEFoursquareAppDelegateService.h"
#import "TMEGoogleAnalyticsAppDelegateService.h"
#import "TMEFlurryAppDelegateService.h"
#import "TMEReachabilityAppDelegateService.h"
#import "TMEVersionCheckerAppDelegateService.h"
#import "TMEApperanceAppDelegateService.h"
#import "TMELoggerAppDelegateService.h"
#import "TMEGooglePlusAppDelegateService.h"
#import "TMEDeviceManagerAppDelegateService.h"
#import "TMEUserManagerAppDelegateService.h"


@interface AppDelegate()

@property (nonatomic, strong) NSArray *appDelegateServices;

@end

@implementation AppDelegate

#pragma mark - AppDelegate Services
- (NSArray *)appDelegateServices
{
    // NOTE: Order matters
    if (!_appDelegateServices) {
        _appDelegateServices = @[[TMEUserManagerAppDelegateService new],
                                 [TMERootAppDelegateService new],
                                 [TMEPushNotificationAppDelegateService new],
                                 [TMEFacebookAppDelegateService new],
                                 [TMECrittercismAppDelegateService new],
                                 [TMECoreDataAppDelegateService new],
                                 [TMEFoursquareAppDelegateService new],
                                 [TMEGoogleAnalyticsAppDelegateService new],
                                 [TMEFlurryAppDelegateService new],
                                 [TMEReachabilityAppDelegateService new],
                                 [TMEVersionCheckerAppDelegateService new],
                                 [TMEApperanceAppDelegateService new],
                                 [TMELoggerAppDelegateService new],
                                 [TMEGooglePlusAppDelegateService new],
                                 [TMEDeviceManagerAppDelegateService new],
                                 ];
    }

    return _appDelegateServices;
}


#pragma mark - UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    for (id<UIApplicationDelegate> service in self.appDelegateServices) {
        if ([service respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
            [service application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }


    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    for (id<UIApplicationDelegate> service in self.appDelegateServices) {
        if ([service respondsToSelector:@selector(applicationDidBecomeActive:)]) {
            [service applicationDidBecomeActive:application];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    for (id<UIApplicationDelegate> service in self.appDelegateServices) {
        if ([service respondsToSelector:@selector(applicationWillResignActive:)]) {
            [service applicationWillResignActive:application];
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    for (id<UIApplicationDelegate> service in self.appDelegateServices) {
        if ([service respondsToSelector:@selector(applicationDidEnterBackground:)]) {
            [service applicationDidEnterBackground:application];
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    for (id<UIApplicationDelegate> service in self.appDelegateServices) {
        if ([service respondsToSelector:@selector(applicationWillEnterForeground:)]) {
            [service applicationWillEnterForeground:application];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    for (id<UIApplicationDelegate> service in self.appDelegateServices) {
        if ([service respondsToSelector:@selector(applicationWillTerminate:)]) {
            [service applicationWillTerminate:application];
        }
    }
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    for (id<UIApplicationDelegate> service in self.appDelegateServices) {
        if ([service respondsToSelector:@selector(applicationDidReceiveMemoryWarning:)]) {
            [service applicationDidReceiveMemoryWarning:application];
        }
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    for (id<UIApplicationDelegate> service in self.appDelegateServices) {
        if ([service respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)]) {
            [service application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    for (id<UIApplicationDelegate> service in self.appDelegateServices) {
        if ([service respondsToSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:)]) {
            [service application:application didFailToRegisterForRemoteNotificationsWithError:error];
        }
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    for (id<UIApplicationDelegate> service in self.appDelegateServices) {
        if ([service respondsToSelector:@selector(application:didReceiveRemoteNotification:)]) {
            [service application:application didReceiveRemoteNotification:userInfo];
        }
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    for (id<UIApplicationDelegate> service in self.appDelegateServices) {
        if ([service respondsToSelector:@selector(application:openURL:sourceApplication:annotation:)]) {
            if ([service application:application openURL:url sourceApplication:sourceApplication annotation:annotation]) {
                return YES;
            }
        }
    }

    return NO;
}

#pragma mark - Helper
+ (AppDelegate *)sharedDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

@end
