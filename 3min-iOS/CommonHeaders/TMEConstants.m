//
//  TMEConstants.m
//  ThreeMin
//
//  Created by Khoa Pham on 7/17/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEConstants.h"

NSString *const TMEShowLoginViewControllerNotification = @"TMEShowLoginViewControllerNotification";
NSString *const TMEShowHomeViewControllerNotification = @"TMEShowHomeViewControllerNotification";

NSString *const TMECategoryDidChangeNotification = @"TMECategoryDidChangeNotification";

NSString *const TMEUserDidLoginNotification = @"TMEUserDidLoginNotification";
NSString *const TMEUserDidLogoutNotification = @"TMEUserDidLogoutNotification";

// CocoaLumberJack
#import <CocoaLumberjack/DDLog.h>
#ifdef DEBUG
    int const ddLogLevel = LOG_LEVEL_VERBOSE;
#else
    int const ddLogLevel = LOG_LEVEL_WARN;
#endif