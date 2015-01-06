//
//  TMEPageViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 26/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEPageViewController.h"
#import "TMEHomeNavigationButtonDelegate.h"
#import "TMEHomePageViewDatasource.h"
#import "UIColor+Additions.h"

@interface TMEPageViewController()
<
    UIPageViewControllerDelegate
>

@property (nonatomic, strong, readwrite) UIViewController *currentViewController;
@property (nonatomic, strong) TMEHomePageViewDatasource *pageDataSource;
@property (nonatomic, strong) TMEHomeNavigationButtonDelegate *buttonsController;

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
        _currentViewController = startingViewController;
		[self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    return self;
}

- (TMEHomeNavigationButtonDelegate *)buttonsController {
    if (!_buttonsController) {
        _buttonsController = [[TMEHomeNavigationButtonDelegate alloc] initWithPageViewController:self navigationViewController:self.navigationController];
    }
    return _buttonsController;
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
    [button setTitleColor:[UIColor colorWithHexString:@"#FF938D"] forState:UIControlStateNormal];
    [button setTitle:@"Everything" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont openSansRegularFontWithSize:21]];
    [button addTarget:self.buttonsController action:@selector(onTapTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    button.selected = YES;
    UIImageView *dropdownImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arow_dropdown_hide"]
                                                   highlightedImage:[UIImage imageNamed:@"arow_dropdown"]];
    dropdownImage.center = CGPointMake(CGRectGetMidX(button.bounds)*1.7, CGRectGetMidY(button.bounds));
    [button addSubview:dropdownImage];
    [titleView addSubview:button];
    return titleView;
}

- (UIBarButtonItem *)searchIcon {
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 40)];
    [searchBtn setImage:[UIImage imageNamed:@"icn_search_hide"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"icn_search"] forState:UIControlStateSelected];
    [searchBtn addTarget:self.buttonsController action:@selector(onTapSearchButton:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.opaque = YES;
    UIBarButtonItem *searchIcon = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    return searchIcon;
}

- (UIBarButtonItem *)profileIcon {
    UIButton *profileBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 40)];
    [profileBtn setImage:[UIImage imageNamed:@"icn_profile_hide"] forState:UIControlStateNormal];
    [profileBtn setImage:[UIImage imageNamed:@"icn_profile"] forState:UIControlStateSelected];
    [profileBtn addTarget:self.buttonsController action:@selector(onTapProfileButton:) forControlEvents:UIControlEventTouchUpInside];
    profileBtn.opaque = YES;
    UIBarButtonItem *searchIcon = [[UIBarButtonItem alloc] initWithCustomView:profileBtn];
    return searchIcon;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    self.currentViewController = pageViewController.viewControllers[0];
}

- (void)goToSearchViewController {
    [self pageViewControllerGoesToViewController:self.pageDataSource.searchVC];
}

- (void)goToProfileViewController {
    [self pageViewControllerGoesToViewController:self.pageDataSource.profileVC];
}

- (void)goToBrowserProductViewController {
    [self pageViewControllerGoesToViewController:self.pageDataSource.browserVC];
}

- (UIPageViewControllerNavigationDirection)directionToViewController:(UIViewController *)viewController {
    NSUInteger currentPage = [self.pageDataSource indexOfViewController:self.currentViewController];
    NSUInteger nextPage = [self.pageDataSource indexOfViewController:viewController];
    return currentPage > nextPage ? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward;
}

- (void)pageViewControllerGoesToViewController:(UIViewController *)nextViewController {
    __weak typeof(self)weakSelf = self;
    UIPageViewControllerNavigationDirection direction = [self directionToViewController:nextViewController];
    [self setViewControllers:@[nextViewController] direction:direction animated:YES completion:^(BOOL finished) {
        weakSelf.currentViewController = nextViewController;
    }];
}

@end
