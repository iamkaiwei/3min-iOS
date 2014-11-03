//
//  TMEFollowingCollectionViewCell.m
//  ThreeMin
//
//  Created by Triệu Khang on 1/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEFollowingCollectionViewCell.h"

@interface TMEFollowingCollectionViewCell ()

@property (weak, nonatomic) IBOutlet KHRoundAvatar *imgViewUserAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UIButton *btnFollow;

@end

@implementation TMEFollowingCollectionViewCell

- (void)awakeFromNib {
	[super awakeFromNib];
	[self.contentView mas_makeConstraints: ^(MASConstraintMaker *make) {
	    make.top.equalTo(self);
	    make.left.equalTo(self);
	    make.right.equalTo(self);
	    make.bottom.equalTo(self);
	}];

	[self setNeedsUpdateConstraints];
	[self layoutIfNeeded];
}

- (void)configWithData:(id)data {
	if (![data isKindOfClass:[TMEUser class]]) {
		return;
	}

	TMEUser *user = (TMEUser *)data;

	[self.imgViewUserAvatar setImageWithURL:[NSURL URLWithString:user.avatar]];
	self.lblUsername.text = user.fullName;

	self.btnFollow.selected = [user.followed boolValue];
}

- (void)prepareForReuse {
	self.imgViewUserAvatar.image = nil;
	self.lblUsername.text = @"";
    self.btnFollow.selected = NO;
}

- (IBAction)onTapButtonFollow:(id)sender {
    if ([self.delegate respondsToSelector:@selector(onFollowButton:)]) {
        [self.delegate onFollowButton:self];
    }
}

@end
