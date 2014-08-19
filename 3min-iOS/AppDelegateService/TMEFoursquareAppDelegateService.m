//
//  TMEFoursquareAppDelegateService.m
//  ThreeMin
//
//  Created by Khoa Pham on 7/16/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEFoursquareAppDelegateService.h"
#import <Foursquare-API-v2/Foursquare2.h>

@implementation TMEFoursquareAppDelegateService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Foursquare2 setupFoursquareWithClientId:@"UTG1422BL21NVOSHA24C2FGEQXVYWYWXHBSSP0XNBSLVPIAM"
                                      secret:@"PMK2RVQ5EEOJH3ZVINAIDUZPXR3QZED3MYDRWMQYQDCOMR0W"
                                 callbackURL:@"3mins://foursquare"];

    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    NSString *specifier = [[url resourceSpecifier] lowercaseString];

    if ([specifier contains:@"foursquare"]) {
        return [Foursquare2 handleURL:url];
    }

    return NO;
}

@end
