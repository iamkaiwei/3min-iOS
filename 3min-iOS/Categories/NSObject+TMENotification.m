//
//  NSObject+TMENotification.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/19/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "NSObject+TMENotification.h"

@implementation NSObject (TMENotification)

- (void)tme_registerNotifications:(NSDictionary *)notifications
{
    for (NSString *name in notifications.allKeys) {
        SEL handle = NSSelectorFromString(notifications[name]);

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:handle
                                                     name:name
                                                   object:nil];
    }
}

- (void)tme_unregisterNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
