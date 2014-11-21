//
//  TMEAlertController.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/21/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEAlertController.h"

@implementation TMEAlertController

+ (void)showMessage:(NSString *)message fromVC:(UIViewController *)vc
{
    PSTAlertController *alertController = [PSTAlertController alertControllerWithTitle:@"" message:message preferredStyle:PSTAlertControllerStyleAlert];
    [alertController addAction:[PSTAlertAction actionWithTitle:@"OK" handler:nil]];

    [alertController showWithSender:nil controller:vc animated:YES completion:nil];
}

+ (void)showMessage:(NSString *)message fromVC:(UIViewController *)vc actionButton:(NSString *)actionButton handler:(void (^)())block
{
    PSTAlertController *alertController = [PSTAlertController alertControllerWithTitle:@"" message:message preferredStyle:PSTAlertControllerStyleAlert];

    [alertController addCancelActionWithHandler:nil];
    [alertController addAction:[PSTAlertAction actionWithTitle:actionButton handler:^(PSTAlertAction *action) {
        if (block) {
            block();
        }
    }]];

    [alertController showWithSender:nil controller:vc animated:YES completion:nil];
}

@end
