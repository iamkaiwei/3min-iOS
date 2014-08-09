//
//  TMEHomePageViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEHomePageViewController.h"

@interface TMEHomePageViewController ()

@end

@implementation TMEHomePageViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
    [self addPageViewControllerAndDisplay];
}

- (void)addPageViewControllerAndDisplay {

	[self addChildViewController:self.pageViewController];
	[self.view addSubview:self.pageViewController.view];

	CGRect pageViewRect = self.view.bounds;
	self.pageViewController.view.frame = pageViewRect;

	[self.pageViewController didMoveToParentViewController:self];

	self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
}

- (UIPageViewController *)pageViewController {
	if (!_pageViewController) {
		_pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
		                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
		                                                                        options:nil];
		_pageViewDataSource = [[TMEHomePageViewDatasource alloc] init];
		_pageViewController.dataSource = self.pageViewDataSource;

		UIViewController *startingViewController = self.pageViewDataSource.browserVC;
		NSArray *viewControllers = @[startingViewController];
		[_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
	}

	return _pageViewController;
}

@end
