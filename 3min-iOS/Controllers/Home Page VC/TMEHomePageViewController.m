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
	UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:self.pageViewController];

    navVC.navigationBar.translucent = NO;
    navVC.navigationBar.barTintColor = [UIColor colorWithHexString:@"#FF0000"];

	[self addChildViewController:navVC];
	[self.view addSubview:navVC.view];

	CGRect pageViewRect = self.view.bounds;
	navVC.view.frame = pageViewRect;

	[navVC didMoveToParentViewController:self];

	self.view.gestureRecognizers = navVC.view.gestureRecognizers;
}

- (UIPageViewController *)pageViewController {
	if (!_pageViewController) {
		_pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
		                                                      navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
		                                                                    options:nil];
		_pageViewController.edgesForExtendedLayout = UIRectEdgeNone;

		_pageViewDataSource = [[TMEHomePageViewDatasource alloc] init];
		_pageViewController.dataSource = self.pageViewDataSource;

		UIViewController *startingViewController = self.pageViewDataSource.browserVC;
		NSArray *viewControllers = @[startingViewController];
		[_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
	}

	return _pageViewController;
}

@end
