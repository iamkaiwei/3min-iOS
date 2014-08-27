//
//  TMEHomeNavigationButtonDelegate.m
//  ThreeMin
//
//  Created by Triệu Khang on 27/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEHomeNavigationButtonDelegate.h"

@interface TMEHomeNavigationButtonDelegate()

@property (weak, nonatomic) TMEPageViewController *pageViewController;
@property (weak, nonatomic) TMENavigationViewController *navViewController;

@end

@implementation TMEHomeNavigationButtonDelegate

- (id)init {
    NSAssert(NO, @"Have to call initWithPageViewController:navigationViewController:");
    self = [self initWithPageViewController:nil navigationViewController:nil];
    return nil;
}

- (instancetype)initWithPageViewController:(TMEPageViewController *)pageVC navigationViewController:(TMENavigationViewController *)navVC {
    NSParameterAssert(pageVC);
    NSParameterAssert(navVC);
    self = [super init];
    if (self) {
        _pageViewController = pageVC;
        _navViewController = navVC;
    }

    return self;
}

- (void)onTapSearchButton:(UIButton *)sender {
    [self.pageViewController goToSearchViewController];
}

- (void)onTapProfileButton:(UIButton *)sender {
    [self.pageViewController goToProfileViewController];
}

- (void)onTapTitleButton:(UIButton *)sender {
    [self.pageViewController goToBrowserProductViewController];
}

@end
