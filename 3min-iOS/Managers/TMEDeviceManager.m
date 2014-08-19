//
//  TMEDeviceManager.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/18/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEDeviceManager.h"

static NSString *const kUDIDKey = @"kUDIDKey";

@implementation TMEDeviceManager

OMNIA_SINGLETON_M(sharedManager)

- (void)load
{
    NSString *UDID = [[NSUserDefaults standardUserDefaults] objectForKey:kUDIDKey];
    if (!UDID) {
        UDID = [[NSUUID UUID] UUIDString];

        [[NSUserDefaults standardUserDefaults] setObject:UDID forKey:kUDIDKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    self.UDID = UDID;
}

@end
