//
//  TMEViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 22/9/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEOtherTopProfileViewController.h"

@interface TMEOtherTopProfileViewController ()

@property (weak, nonatomic) IBOutlet UIView *loadingScreen;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet KHRoundAvatar *imgUserAvatar;
@property (weak, nonatomic) IBOutlet UIButton *btnFollow;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *followingProgressIndicator;

@end

@implementation TMEOtherTopProfileViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	[self _loadingUserInformation];
}

- (void)_loadingUserInformation {
	self.loadingScreen.hidden = NO;
	TMEUserNetworkClient *client = [[TMEUserNetworkClient alloc] init];
	[client getFullInformationWithUserID:[self.user.userID integerValue] success: ^(TMEUser *user) {
	    [self _configWithUser:user];
	    self.loadingScreen.hidden = YES;
	} failure: ^(NSError *error) {
	    self.loadingScreen.hidden = YES;
	}];
}

#pragma mark - Private method

- (void)_configWithUser:(TMEUser *)user {
	self.lblUsername.text = user.fullName;
	[self.imgUserAvatar setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:nil];
}

- (void)updateViewConstraints {
	[super updateViewConstraints];

	[self.view mas_remakeConstraints: ^(MASConstraintMaker *make) {
	    make.leading.equalTo(self.view.superview).with.offset(0);
	    make.top.equalTo(self.view.superview).with.offset(0);
	    make.width.equalTo(@(self.view.width));
	}];

	[self.view.superview layoutIfNeeded];
}

#pragma mark - Action

- (IBAction)btmMyItems:(id)sender {
}

- (IBAction)btnMyLikes:(id)sender {
}

- (IBAction)btnEdit:(id)sender {
}

@end
