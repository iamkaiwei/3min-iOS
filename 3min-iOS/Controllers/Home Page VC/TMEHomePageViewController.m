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
	TMEHomeNavigationViewController *navVC = [[TMEHomeNavigationViewController alloc] initWithRootViewController:self.pageViewController];

	[self addChildViewController:navVC];
	[self.view addSubview:navVC.view];

	CGRect pageViewRect = self.view.bounds;
	navVC.view.frame = pageViewRect;

	[navVC didMoveToParentViewController:self];

	self.view.gestureRecognizers = navVC.view.gestureRecognizers;
}

- (UIPageViewController *)pageViewController {
	if (!_pageViewController) {
		_pageViewController = [[TMEPageViewController alloc] init];
	}

	return _pageViewController;
}

@end
