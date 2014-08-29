//
//  TMEHomeNavigationButtonDelegate.m
//  ThreeMin
//
//  Created by Triệu Khang on 27/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEHomeNavigationButtonDelegate.h"
#import "TMEDropDownMenuViewController.h"

@interface TMEHomeNavigationButtonDelegate ()

@property (weak, nonatomic) TMEPageViewController *pageViewController;
@property (weak, nonatomic) TMENavigationViewController *navViewController;

@property (assign, nonatomic) BOOL isShowingMenu;

@property (strong, nonatomic) TMEDropDownMenuViewController *dropdownVC;

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

- (TMEDropDownMenuViewController *)dropdownVC {
    if (!_dropdownVC) {
        _dropdownVC = [[TMEDropDownMenuViewController alloc] init];
    }
    return _dropdownVC;
}

- (void)tongleMenu {
	if (self.isShowingMenu == YES) {
		[self.dropdownVC.view removeFromSuperview];
		[self.dropdownVC removeFromParentViewController];
		self.isShowingMenu = NO;
		return;
	}

	self.isShowingMenu = YES;

	self.dropdownVC.view.frame = ({
	                                    CGRect frame = self.navViewController.view.bounds;
	                                    frame.origin = CGPointMake(0, 64);
	                                    frame;
									});

	[self.navViewController addChildViewController:self.dropdownVC];
	[self.navViewController.view addSubview:self.dropdownVC.view];
	[self.dropdownVC didMoveToParentViewController:self.navViewController];

    UITapGestureRecognizer *tapToDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tongleMenu)];
    tapToDismiss.numberOfTouchesRequired = 1;
    [self.dropdownVC.view addGestureRecognizer:tapToDismiss];
}

@end
