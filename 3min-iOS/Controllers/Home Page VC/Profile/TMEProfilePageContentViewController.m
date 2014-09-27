//
//  TMEProfilePageContentViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProfilePageContentViewController.h"
#import "TMEMyTopProfileViewController.h"
#import "TMEListActiviesViewController.h"

@interface TMEProfilePageContentViewController ()

@property (strong, nonatomic) UIViewController *topVC;
@property (strong, nonatomic) UIViewController *activitiesVC;

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

    TMEListActiviesViewController *activitiesVC = [[TMEListActiviesViewController alloc] init];
    [self addChildViewController:activitiesVC];
    [activitiesVC willMoveToParentViewController:self];
    [self.view addSubview:activitiesVC.view];
    [activitiesVC didMoveToParentViewController:self];

    self.activitiesVC = activitiesVC;

    [self.view layoutIfNeeded];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];

    [self.topVC.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(0);
        make.height.equalTo(@160);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
    }];

    [self.view layoutIfNeeded];

    [self.activitiesVC.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.view).with.offset(160);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
    }];

    [self.view layoutIfNeeded];
}

@end
