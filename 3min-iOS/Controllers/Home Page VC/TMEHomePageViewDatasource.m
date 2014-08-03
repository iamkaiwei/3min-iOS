//
//  TMEHomePageViewDatasource.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEHomePageViewDatasource.h"

@interface TMEHomePageViewDatasource()

@property (strong, nonatomic) TMEHomePageViewController *pageVC;

@end

@implementation TMEHomePageViewDatasource

- (TMESearchPageContentViewController *)searchVC {
    if (!_searchVC) {
        _searchVC = [[TMESearchPageContentViewController alloc] init];
    }
    return _searchVC;
}

- (TMEBrowserPageContentViewController *)browserVC {
    if (!_browserVC) {
        _browserVC = [[TMEBrowserPageContentViewController alloc] init];
    }
    return _browserVC;
}

- (TMEProfilePageContentViewController *)profileVC {
    if (!_profileVC) {
        _profileVC = [[TMEProfilePageContentViewController alloc] init];
    }

    return _profileVC;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {

    NSDictionary *controllers = @{
                                  NSStringFromClass([TMESearchPageContentViewController class]): [NSNull null],
                                  NSStringFromClass([TMEBrowserPageContentViewController class]): self.searchVC,
                                  NSStringFromClass([TMEProfilePageContentViewController class]): self.browserVC,
                                  };

    return controllers[NSStringFromClass([viewController class])] ?: nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {

    NSDictionary *controllers = @{
                                  NSStringFromClass([TMESearchPageContentViewController class]): self.browserVC,
                                  NSStringFromClass([TMEBrowserPageContentViewController class]): self.profileVC,
                                  NSStringFromClass([TMEProfilePageContentViewController class]): [NSNull null],
                                  };

    return controllers[NSStringFromClass([viewController class])] ?: nil;
}

@end
