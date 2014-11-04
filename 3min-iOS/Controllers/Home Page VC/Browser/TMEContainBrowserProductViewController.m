//
//  TMEContainBrowserProductViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEContainBrowserProductViewController.h"
#import "TMEBrowserPageContentViewController.h"

@interface TMEContainBrowserProductViewController ()

@property (strong, nonatomic) TMEBrowserPageContentViewController *childVC;

@end

@implementation TMEContainBrowserProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.childVC willMoveToParentViewController:self];
    [self addChildViewController:self.childVC];
    [self.view addSubview:self.childVC.view];
    [self.childVC didMoveToParentViewController:self];
    [self.view layoutIfNeeded];
}

- (TMEBrowserPageContentViewController *)childVC {
    if (!_childVC) {
        _childVC = [[TMEBrowserPageContentViewController alloc] init];
    }

    return _childVC;
}

@end
