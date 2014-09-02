//
//  TMEAlertView.m
//  ThreeMin
//
//  Created by Khoa Pham on 9/2/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEAlertView.h"
#import <SIAlertView/SIAlertView.h>

@implementation TMEAlertView

+ (void)showMessage:(NSString *)message
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"ThreeMin"
                                                     andMessage:message];

    [alertView addButtonWithTitle:@"OK" type:SIAlertViewButtonTypeDefault handler:nil];
    [alertView show];
}

@end
