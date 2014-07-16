//
//  TMEFacebookAppDelegateService.m
//  ThreeMin
//
//  Created by Khoa Pham on 7/16/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEFacebookAppDelegateService.h"
#import <FacebookSDK/FacebookSDK.h>

@interface TMEFacebookAppDelegateService () <FacebookManagerDelegate>

@end

@implementation TMEFacebookAppDelegateService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Facebook Stuffs
    [FBLoginView class];
    [FacebookManager sharedInstance].delegate = (id) self;
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {

        // ASK: What is openSession ?
        [self openSession];

        [[NSNotificationCenter defaultCenter] postNotificationName:TMEShowHomeViewControllerNotification
                                                            object:nil];

    } else {
        // No, display the login page.
        [[NSNotificationCenter defaultCenter] postNotificationName:TMEShowLoginViewControllerNotification
                                                            object:nil];
    }

    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSession.activeSession handleDidBecomeActive];
    [FBAppEvents activateApp];
    [FBAppCall handleDidBecomeActive];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RELOAD_CONVERSATION object:nil];
}

- (void)openSession
{
    // FIXME: loop call
    //[[FacebookManager sharedInstance] openSession];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [FBSession.activeSession close];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}

@end
