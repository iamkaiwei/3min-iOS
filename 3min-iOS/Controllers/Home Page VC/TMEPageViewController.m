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

    self.navigationItem.titleView = [self titleView];
    self.navigationItem.leftBarButtonItem = [self searchIcon];
    self.navigationItem.rightBarButtonItem = [self profileIcon];
}

- (UIView *)titleView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(60, 0, 200, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:titleView.bounds];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor colorWithHexString:@"#FF938D"] forState:UIControlStateNormal];
    [button setTitle:@"Controller title" forState:UIControlStateNormal];
    button.highlighted = YES;
    [titleView addSubview:button];
    return titleView;
}

- (UIBarButtonItem *)searchIcon {
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 40)];
    [searchBtn setImage:[UIImage imageNamed:@"icn_search_hide"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"icn_search"] forState:UIControlStateHighlighted];
    searchBtn.opaque = YES;
    UIBarButtonItem *searchIcon = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    return searchIcon;
}

- (UIBarButtonItem *)profileIcon {
    UIButton *profileBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 40)];
    [profileBtn setImage:[UIImage imageNamed:@"icn_profile_hide"] forState:UIControlStateNormal];
    [profileBtn setImage:[UIImage imageNamed:@"icn_profile"] forState:UIControlStateHighlighted];
    profileBtn.opaque = YES;
    UIBarButtonItem *searchIcon = [[UIBarButtonItem alloc] initWithCustomView:profileBtn];
    return searchIcon;
}


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    self.currentViewController = pageViewController.viewControllers[0];
}

@end
