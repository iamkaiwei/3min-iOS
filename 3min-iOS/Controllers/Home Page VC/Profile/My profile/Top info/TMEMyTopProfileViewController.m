//
//  TMEViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 22/9/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEMyTopProfileViewController.h"

@interface TMEMyTopProfileViewController ()

@property (weak, nonatomic) IBOutlet KHRoundAvatar *imgUserAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIButton *btnPositive;
@property (weak, nonatomic) IBOutlet UIButton *btnFollower;
@property (weak, nonatomic) IBOutlet UIButton *btnFollowing;

@end

@implementation TMEMyTopProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self configWithUser:[[TMEUserManager sharedManager] loggedUser]];
}

- (void)configWithUser:(TMEUser *)user {
    [self.imgUserAvatar setImageWithURL:[NSURL URLWithString:user.avatar]
                       placeholderImage:[UIImage imageNamed:@"avatar_holding"]];
    self.lblUserName.text = user.fullName;
}

- (void)updateViewConstraints {

    [super updateViewConstraints];

    [self.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.superview).with.offset(0);
        make.top.equalTo(self.view.superview).with.offset(0);
        make.width.equalTo(@(self.view.superview.width));
    }];

    [self.view.superview layoutIfNeeded];
}

@end
