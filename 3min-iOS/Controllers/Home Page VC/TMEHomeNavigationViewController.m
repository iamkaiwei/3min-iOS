//
//  TMEHomeNavigationViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 25/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEHomeNavigationViewController.h"

@implementation TMEHomeNavigationViewController

- (id)init {
	self = [super init];
	if (self) {
	}

	return self;
}

- (void)loadView {
    [super loadView];
	self.navigationBar.translucent = NO;
	self.navigationBar.barTintColor = [UIColor colorWithHexString:@"#FF0000"];
}

@end
