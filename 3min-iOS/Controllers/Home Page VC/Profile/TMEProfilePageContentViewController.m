//
//  TMEProfilePageContentViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProfilePageContentViewController.h"
#import "TMEMyTopProfileViewController.h"
#import "TMEProfilePageContentViewController.h"

@interface TMEProfilePageContentViewController ()

@property (strong, nonatomic) UIViewController *topVC;

@end

@implementation TMEProfilePageContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    TMEMyTopProfileViewController *topVC = [[TMEMyTopProfileViewController alloc] init];
    [self addChildViewController:topVC];
    [topVC willMoveToParentViewController:self];
    [self.view addSubview:topVC.view];
    [topVC didMoveToParentViewController:self];

    self.topVC = topVC;
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
}

@end
