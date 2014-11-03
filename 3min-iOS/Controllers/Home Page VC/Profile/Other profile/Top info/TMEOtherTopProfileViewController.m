//
//  TMEViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 22/9/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEOtherTopProfileViewController.h"

@interface TMEOtherTopProfileViewController ()

@end

@implementation TMEOtherTopProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)updateViewConstraints {

    [super updateViewConstraints];

    [self.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.superview).with.offset(0);
        make.top.equalTo(self.view.superview).with.offset(0);
        make.width.equalTo(@(self.view.width));
    }];

    [self.view.superview layoutIfNeeded];
}

@end
