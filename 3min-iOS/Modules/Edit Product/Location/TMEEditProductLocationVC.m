//
//  TMEEditProductLocationVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/18/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEEditProductLocationVC.h"

@interface TMEEditProductLocationVC ()

@end

@implementation TMEEditProductLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigationItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavigationItems
{
    self.title = @"Location";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem cancelItemWithTarget:self action:@selector(cancelTouched:)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem doneItemWithTarget:self action:@selector(doneTouched:)];
}

#pragma mark - Action
- (void)doneTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
