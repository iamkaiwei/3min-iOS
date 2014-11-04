//
//  TMEHomePageViewDatasource.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEHomePageViewDatasource.h"

@interface TMEHomePageViewDatasource()

@property (nonatomic, strong, readwrite) TMEProfilePageContentViewController *profileVC;
@property (nonatomic, strong, readwrite) TMEContainBrowserProductViewController *browserVC;
@property (nonatomic, strong, readwrite) TMESearchPageContentViewController *searchVC;

@end

@implementation TMEHomePageViewDatasource

- (TMESearchPageContentViewController *)searchVC {
    if (!_searchVC) {
        _searchVC = [[TMESearchPageContentViewController alloc] init];
    }
    return _searchVC;
}

- (TMEContainBrowserProductViewController *)browserVC {
    if (!_browserVC) {
        TMEContainBrowserProductViewController *vc = [[UIStoryboard storyboardWithName:NSStringFromClass([TMEBrowserPageContentViewController class]) bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([TMEContainBrowserProductViewController class])];
        _browserVC = vc;
    }
    return _browserVC;
}

- (TMEProfilePageContentViewController *)profileVC {
    if (!_profileVC) {
        _profileVC = [[TMEProfilePageContentViewController alloc] init];
        _profileVC.user = [[TMEUserManager sharedManager] loggedUser];
    }

    return _profileVC;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {

    NSDictionary *controllers = @{
                                  NSStringFromClass([TMESearchPageContentViewController class]): [NSNull null],
                                  NSStringFromClass([TMEContainBrowserProductViewController class]): self.searchVC,
                                  NSStringFromClass([TMEProfilePageContentViewController class]): self.browserVC,
                                  };

    id vc = controllers[NSStringFromClass([viewController class])];
    return [vc isEqual:[NSNull null]] ? nil : vc;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {

    NSDictionary *controllers = @{
                                  NSStringFromClass([TMESearchPageContentViewController class]): self.browserVC,
                                  NSStringFromClass([TMEContainBrowserProductViewController class]): self.profileVC,
                                  NSStringFromClass([TMEProfilePageContentViewController class]): [NSNull null],
                                  };

    id vc = controllers[NSStringFromClass([viewController class])];
    return [vc isEqual:[NSNull null]] ? nil : vc;
}

- (NSUInteger)indexOfViewController:(UIViewController *)controller {
    NSNumber *page = @{NSStringFromClass([TMESearchPageContentViewController class]): @1,
      NSStringFromClass([TMEContainBrowserProductViewController class]): @2,
      NSStringFromClass([TMEProfilePageContentViewController class]): @3}[NSStringFromClass([controller class])];
    NSAssert(page, @"Index not found");
    return [page integerValue];
}

@end
