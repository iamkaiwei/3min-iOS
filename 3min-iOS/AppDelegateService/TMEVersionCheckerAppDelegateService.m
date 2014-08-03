//
//  TMEVersionCheckerAppDelegateService.m
//  ThreeMin
//
//  Created by Khoa Pham on 7/16/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEVersionCheckerAppDelegateService.h"

@implementation TMEVersionCheckerAppDelegateService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [VENVersionTracker beginTrackingVersionForChannel:@"internal"
                                       serviceBaseUrl:@"https://www.dropbox.com/sh/ijwghminfsqwd0n/s3t44SLYPf/version"
                                         timeInterval:1800
                                          withHandler:^(VENVersionTrackerState state, VENVersion *version) {
                                              [self handleVersionTrackingResultState:state
                                                                             version:version];

                                          }];

    return YES;
}

#pragma mark - Helper
- (void)handleVersionTrackingResultState:(VENVersionTrackerState)state
                                 version:(VENVersion *)version
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        switch (state) {
            case VENVersionTrackerStateDeprecated:
                [version install];
                break;

            case VENVersionTrackerStateOutdated:
            {
                // Offer the user the option to update
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Update required", nil) message:NSLocalizedString(@"There is a newer version, please update to get the best experience", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
                [alertView show];

                break;
            }
            default:
                break;
        }
    });
}

@end
