//
//  TMEConstants.h
//  ThreeMin
//
//  Created by Khoa Pham on 7/17/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

typedef void(^TMEFailureBlock)(NSError *error);
typedef void(^TMESuccessBlock)();
typedef void(^TMEArraySuccessBlock)();

extern NSString *const TMEShowLoginViewControllerNotification;
extern NSString *const TMEShowHomeViewControllerNotification;

extern NSString *const TMECategoryDidChangeNotification;

extern NSString *const TMEUserDidLoginNotification;
extern NSString *const TMEUserDidLogoutNotification;

extern NSString *const TMEHomeCategoryDidChangedNotification;

// CocoaLumberJack
extern int const ddLogLevel;