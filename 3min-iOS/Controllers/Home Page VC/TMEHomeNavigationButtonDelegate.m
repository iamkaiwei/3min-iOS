//
//  TMEHomeNavigationButtonDelegate.m
//  ThreeMin
//
//  Created by Triệu Khang on 27/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEHomeNavigationButtonDelegate.h"

@interface TMEHomeNavigationButtonDelegate ()

@property (weak, nonatomic) TMEPageViewController *pageViewController;
@property (weak, nonatomic) TMENavigationViewController *navViewController;

@property (strong, nonatomic) UIViewController *backgroundVC;
@property (assign, nonatomic) BOOL isShowingMenu;

@end

@implementation TMEHomeNavigationButtonDelegate

- (id)init {
	NSAssert(NO, @"Have to call initWithPageViewController:navigationViewController:");
	self = [self initWithPageViewController:nil navigationViewController:nil];
	return nil;
}

- (instancetype)initWithPageViewController:(TMEPageViewController *)pageVC navigationViewController:(TMENavigationViewController *)navVC {
	NSParameterAssert(pageVC);
	NSParameterAssert(navVC);
	self = [super init];
	if (self) {
		_pageViewController = pageVC;
		_navViewController = navVC;
	}

	return self;
}

- (void)onTapSearchButton:(UIButton *)sender {
    if (self.isShowingMenu) {
        [self tongleMenu];
        return;
    }
	[self.pageViewController goToSearchViewController];
}

- (void)onTapProfileButton:(UIButton *)sender {
    if (self.isShowingMenu) {
        [self tongleMenu];
        return;
    }
	[self.pageViewController goToProfileViewController];
}

- (void)onTapTitleButton:(UIButton *)sender {
    if (self.isShowingMenu) {
        [self tongleMenu];
        return;
    }

	[self.pageViewController goToBrowserProductViewController];
	[self tongleMenu];
}

- (void)tongleMenu {
	if (self.isShowingMenu == YES) {
		[self.backgroundVC.view removeFromSuperview];
		[self.backgroundVC removeFromParentViewController];
		self.isShowingMenu = NO;
		return;
	}

	self.isShowingMenu = YES;
	self.backgroundVC = [[UIViewController alloc] init];

	self.backgroundVC.view.frame = ({
	                                    CGRect frame = self.navViewController.view.bounds;
	                                    frame.origin = CGPointMake(0, 64);
	                                    frame;
									});

	self.backgroundVC.view.backgroundColor = [UIColor grayColor];
	[self.navViewController addChildViewController:self.backgroundVC];
	[self.navViewController.view addSubview:self.backgroundVC.view];
	[self.backgroundVC didMoveToParentViewController:self.navViewController];

    UITapGestureRecognizer *tapToDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tongleMenu)];
    tapToDismiss.numberOfTouchesRequired = 1;
    [self.backgroundVC.view addGestureRecognizer:tapToDismiss];
}

@end
