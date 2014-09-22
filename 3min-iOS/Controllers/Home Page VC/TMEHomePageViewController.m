//
//  TMEHomePageViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEHomePageViewController.h"
#import "TMEPageViewController.h"

@interface TMEHomePageViewController ()

@property (nonatomic, strong, readwrite) TMEHomeNavigationViewController *navVC;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) TMEHomePageViewDatasource *pageViewDataSource;

@end

@implementation TMEHomePageViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self addPageViewControllerAndDisplay];
	self.view.backgroundColor = [UIColor whiteColor];
}

- (TMEHomeNavigationViewController *)navVC {
	if (!_navVC) {
		_navVC = [[TMEHomeNavigationViewController alloc] initWithRootViewController:self.pageViewController];
	}
    return _navVC;
}

- (void)addPageViewControllerAndDisplay {
	[self addChildViewController:self.navVC];
	[self.view addSubview:self.navVC.view];

	self.navVC.view.frame = self.view.bounds;

	[self.navVC didMoveToParentViewController:self];

	self.view.gestureRecognizers = self.navVC.view.gestureRecognizers;
}

- (UIPageViewController *)pageViewController {
	if (!_pageViewController) {
		_pageViewController = [[TMEPageViewController alloc] init];
	}

	return _pageViewController;
}

@end
