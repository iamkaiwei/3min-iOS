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
                typeof(self) innerSelf = observer;
			    UIViewController *viewController = change[NSKeyValueChangeNewKey];
                [innerSelf selectButtonBaseOnViewController:viewController];
			}];
		}
	}

	return self;
}

- (void)loadView {
	[super loadView];
	self.navigationBar.translucent = NO;
	self.navigationBar.barTintColor = [UIColor colorWithHexString:@"#FF0000"];
}

#pragma mark -

- (void)selectButtonBaseOnViewController:(UIViewController *)viewController {
    UIViewController *rootViewController = self.viewControllers[0];
	NSArray *buttons = @[rootViewController.navigationItem.leftBarButtonItem,
	                     rootViewController.navigationItem.rightBarButtonItem,
	                     rootViewController.navigationItem.titleView];

	NSArray *classes = @[[TMESearchPageContentViewController class],
	                     [TMEProfilePageContentViewController class],
	                     [TMEBrowserPageContentViewController class]];

	[buttons enumerateObjectsUsingBlock: ^(UIView *view, NSUInteger idx, BOOL *stop) {
	    UIButton *button = [view getButton];
	    BOOL (^isSelected)(UIViewController *) = ^(UIViewController *vc) {
	        if ([vc isKindOfClass:classes[idx]]) {
	            return YES;
			}
	        return NO;
		};
	    button.selected = isSelected(viewController);
	}];
}

@end
