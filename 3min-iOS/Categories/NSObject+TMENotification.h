//
//  NSObject+TMENotification.h
//  ThreeMin
//
//  Created by Khoa Pham on 8/19/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TMENotification)

- (void)tme_registerNotifications:(NSDictionary *)notifications;
- (void)tme_unregisterNotifications;

@end
