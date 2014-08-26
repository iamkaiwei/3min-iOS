//
//  TMEHomeNavigationViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 25/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEHomeNavigationViewController.h"
#import "UIBarButtonItem+Additions.h"

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

                leftButton.highlighted = NO;
                rightButton.highlighted = NO;

			    if ([viewController isKindOfClass:[TMESearchPageContentViewController class]]) {
			        leftButton.highlighted = YES;
				}
			    if ([viewController isKindOfClass:[TMEProfilePageContentViewController class]]) {
                    rightButton.highlighted = YES;
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
	self.navigationItem.titleView = self.titleView;
	[[FLEXManager sharedManager] showExplorer];
}

- (UIView *)titleView {
	UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
	UILabel *label = [[UILabel alloc] initWithFrame:titleView.frame];
	label.text = @"Khang";
	[titleView addSubview:label];
	return titleView;
}

@end
