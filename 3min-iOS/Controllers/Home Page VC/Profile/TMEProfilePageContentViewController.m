//
//  TMEProfilePageContentViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProfilePageContentViewController.h"
#import "TMEMyTopProfileViewController.h"
#import "TMEOtherTopProfileViewController.h"
#import "TMEListActiviesViewController.h"

@interface TMEProfilePageContentViewController ()

@property (strong, nonatomic) UIViewController *topVC;
@property (strong, nonatomic) UIViewController *activitiesVC;

@end

@implementation TMEProfilePageContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.

	UIViewController *topVC = [self _getTopViewController];
	[self addChildViewController:topVC];
	[topVC willMoveToParentViewController:self];
	[self.view addSubview:topVC.view];
	[topVC didMoveToParentViewController:self];
	self.topVC = topVC;

    UIViewController *activitiesVC = [self _getBottomController];
	[self addChildViewController:activitiesVC];
	[activitiesVC willMoveToParentViewController:self];
	[self.view addSubview:activitiesVC.view];
	[activitiesVC didMoveToParentViewController:self];

	self.activitiesVC = activitiesVC;

	[self.view layoutIfNeeded];
}

- (void)updateViewConstraints {
	[super updateViewConstraints];

	[self.topVC.view mas_remakeConstraints: ^(MASConstraintMaker *make) {
	    make.top.equalTo(self.view).with.offset(0);
	    make.height.equalTo(@160);
	    make.leading.equalTo(self.view);
	    make.trailing.equalTo(self.view);
	}];

	[self.view layoutIfNeeded];

	[self.activitiesVC.view mas_remakeConstraints: ^(MASConstraintMaker *make) {
	    make.bottom.equalTo(self.view).with.offset(0);
	    make.top.equalTo(self.view).with.offset(160);
	    make.leading.equalTo(self.view);
	    make.trailing.equalTo(self.view);
	}];

	[self.view layoutIfNeeded];
}

#pragma mark - private

- (BOOL)_isLoggedInUserProfile {
	if ([self.user.userID isEqual:[[[TMEUserManager sharedManager] loggedUser] userID]]) {
		return YES;
	}

	return NO;
}

- (UIViewController *)_getTopViewController {
	if ([self _isLoggedInUserProfile]) {
		// show my own profile
		TMEMyTopProfileViewController *topVC = [[TMEMyTopProfileViewController alloc] init];
		topVC.user = self.user;
		return topVC;
	}

	// and the orther
	TMEOtherTopProfileViewController *topVC = [[TMEOtherTopProfileViewController alloc] init];
	return topVC;
}

- (UIViewController *)_getBottomController {
	if ([self _isLoggedInUserProfile]) {
		TMEListActiviesViewController *activitiesVC = [[TMEListActiviesViewController alloc] init];
		return activitiesVC;
	}

	TMEListActiviesViewController *activitiesVC = [[TMEListActiviesViewController alloc] init];
	return activitiesVC;
}

@end
