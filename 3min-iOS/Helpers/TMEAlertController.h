//
//  TMEAlertController.h
//  ThreeMin
//
//  Created by Khoa Pham on 11/21/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMEAlertController : NSObject

+ (void)showMessage:(NSString *)message fromVC:(UIViewController *)vc;
+ (void)showMessage:(NSString *)message fromVC:(UIViewController *)vc actionButton:(NSString *)actionButton handler:(void (^)())block;

@end
