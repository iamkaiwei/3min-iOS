//
//  TMEPageViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 26/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEPageViewController.h"

@interface TMEPageViewController()
<
    UIPageViewControllerDelegate
>

@property (nonatomic, strong, readwrite) UIViewController *currentViewController;
@property (nonatomic, strong) TMEHomePageViewDatasource *pageDataSource;

@end

@implementation TMEPageViewController

- (instancetype)init {
    self = [super init];
    if (self) {
		self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
		                                                      navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
		                                                                    options:nil];
		self.edgesForExtendedLayout = UIRectEdgeNone;

		_pageDataSource = [[TMEHomePageViewDatasource alloc] init];
        self.dataSource = _pageDataSource;

		UIViewController *startingViewController = _pageDataSource.browserVC;
		NSArray *viewControllers = @[startingViewController];
		[self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    self.currentViewController = pageViewController.viewControllers[0];
}

@end
