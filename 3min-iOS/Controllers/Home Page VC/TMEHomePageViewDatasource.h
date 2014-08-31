//
//  TMEHomePageViewDatasource.h
//  ThreeMin
//
//  Created by Triệu Khang on 4/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMESearchPageContentViewController.h"
#import "TMEProfilePageContentViewController.h"
#import "TMEBrowserPageContentViewController.h"

@interface TMEHomePageViewDatasource : NSObject <UIPageViewControllerDataSource>

@property (nonatomic, strong, readonly) TMEProfilePageContentViewController *profileVC;
@property (nonatomic, strong, readonly) TMEBrowserPageContentViewController *browserVC;
@property (nonatomic, strong, readonly) TMESearchPageContentViewController *searchVC;

- (NSUInteger)indexOfViewController:(UIViewController *)controller;

@end
