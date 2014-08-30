//
//  TMEHomeNavigationButtonDelegate.h
//  ThreeMin
//
//  Created by Triệu Khang on 27/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMEDropDownMenuViewController.h"

@class TMEDropDownMenuViewController;

@protocol TMEHomeNavigationButtonProtocol <NSObject>

- (void)onTapProfileButton:(UIButton *)sender;
- (void)onTapSearchButton:(UIButton *)sender;
- (void)onTapTitleButton:(UIButton *)sender;
- (void)tongleMenu:(id)sender;

@end

@interface TMEHomeNavigationButtonDelegate : NSObject
<
    TMEHomeNavigationButtonProtocol,
    UIGestureRecognizerDelegate
>

@property (strong, nonatomic, readonly) TMEDropDownMenuViewController *dropdownVC;

- (instancetype)initWithPageViewController:(UIPageViewController *)pageVC navigationViewController:(UINavigationController *)navVC __attribute__((objc_designated_initializer));

@end
