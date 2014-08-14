//
//  TMEGooglePlusAppDelegateService.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/12/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEGooglePlusAppDelegateService.h"
#import <GooglePlus/GooglePlus.h>
#import "TMEGooglePlusManager.h"

@implementation TMEGooglePlusAppDelegateService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[TMEGooglePlusManager sharedManager] setup];

    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [GPPURLHandler handleURL:url
                  sourceApplication:sourceApplication
                         annotation:annotation];
}

@end
