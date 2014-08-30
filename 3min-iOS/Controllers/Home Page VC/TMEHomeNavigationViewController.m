//
//  TMEHomeNavigationViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 25/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEHomeNavigationViewController.h"
#import "UIBarButtonItem+Additions.h"
#import "UIView+TitleViewUtils.h"

@interface TMEHomeNavigationViewController ()

@property (nonatomic, strong) FBKVOController *kvoController;

@end

@implementation TMEHomeNavigationViewController

- (id)init {
	self = [super init];
	if (self) {
	}

	return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
	self = [super initWithRootViewController:rootViewController];
	if (self) {
		if ([rootViewController isKindOfClass:[TMEPageViewController class]]) {
			_kvoController = [[FBKVOController alloc] initWithObserver:self];
			[_kvoController observe:rootViewController keyPath:@"currentViewController" options:NSKeyValueObservingOptionNew block: ^(id observer, id object, NSDictionary *change) {
			    UIViewController *viewController = change[NSKeyValueChangeNewKey];

			    UIButton *leftButton = [rootViewController.navigationItem.leftBarButtonItem getButton];
			    UIButton *rightButton = [rootViewController.navigationItem.rightBarButtonItem getButton];
			    UIButton *centerButton = [rootViewController.navigationItem.titleView getButton];

                leftButton.selected = NO;
                rightButton.selected = NO;
                centerButton.selected = NO;

			    if ([viewController isKindOfClass:[TMESearchPageContentViewController class]]) {
			        leftButton.selected = YES;
				}
			    if ([viewController isKindOfClass:[TMEProfilePageContentViewController class]]) {
			        rightButton.selected = YES;
				}
			    if ([viewController isKindOfClass:[TMEBrowserPageContentViewController class]]) {
                    centerButton.selected = YES;
				}
			}];
		}
	}

	return self;
}

- (void)loadView {
	[super loadView];
	self.navigationBar.translucent = NO;
	self.navigationBar.barTintColor = [UIColor colorWithHexString:@"#FF0000"];
	[[FLEXManager sharedManager] showExplorer];
}

@end
