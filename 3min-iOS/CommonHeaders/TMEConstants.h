//
//  TMEConstants.h
//  ThreeMin
//
//  Created by Khoa Pham on 7/17/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

typedef void(^TMEFailureBlock)(NSError *error);
typedef void(^TMESuccessBlock)();

extern NSString *const TMEShowLoginViewControllerNotification;
extern NSString *const TMEShowHomeViewControllerNotification;

extern NSString *const TMEUserDidLoginNotification;
extern NSString *const TMEUserDidLogoutNotification;

// CocoaLumberJack
extern int const ddLogLevel;