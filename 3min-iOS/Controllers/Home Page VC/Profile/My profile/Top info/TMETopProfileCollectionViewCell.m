//
//  TMETopProfileCollectionViewCell.m
//  ThreeMin
//
//  Created by Triệu Khang on 29/10/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMETopProfileCollectionViewCell.h"

@interface TMETopProfileCollectionViewCell()

@property (weak, nonatomic) IBOutlet KHRoundAvatar *imgUserAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;

@property (weak, nonatomic) IBOutlet UILabel *lblPositive;
@property (weak, nonatomic) IBOutlet UIButton *btnPositive;

@property (weak, nonatomic) IBOutlet UILabel *lblFollower;
@property (weak, nonatomic) IBOutlet UIButton *btnFollower;

@property (weak, nonatomic) IBOutlet UILabel *lblFollowing;
@property (weak, nonatomic) IBOutlet UIButton *btnFollowing;

@end

@implementation TMETopProfileCollectionViewCell

- (void)setSelected:(BOOL)selected {
    [super setSelected:NO];
}

- (void)configWithData:(id)data {
    if (![data isKindOfClass:[TMEUser class]]) {
        return;
    }

    TMEUser *user = (TMEUser *)data;
    [self.imgUserAvatar setImageWithURL:[NSURL URLWithString:user.avatar]
                       placeholderImage:[UIImage imageNamed:@"avatar_holding"]];
    self.lblUserName.text = user.fullName;
    self.lblPositive.text = [user.positive_count stringValue];

    self.lblFollower.text = [user.follower_count stringValue];
    self.lblFollowing.text = [user.following_count stringValue];
}

- (IBAction)onBtnEdit:(id)sender {
    if ([self.delegate respondsToSelector:@selector(onTapEdit)]) {
        [self.delegate onTapEdit];
    }
}

- (IBAction)onBtnMyItems:(id)sender {
    if ([self.delegate respondsToSelector:@selector(onTapMyItems)]) {
        [self.delegate onTapMyItems];
    }
}

- (IBAction)onBtnFollowings:(id)sender {
    if ([self.delegate respondsToSelector:@selector(onTapFollwings)]) {
        [self.delegate onTapFollwings];
    }
}

- (IBAction)onBtnFollwers:(id)sender {
    if ([self.delegate respondsToSelector:@selector(onTapFollowers)]) {
        [self.delegate onTapFollowers];
    }
}

- (IBAction)onBtnPositive:(id)sender {
    if ([self.delegate respondsToSelector:@selector(onTapPositive)]) {
        [self.delegate onTapPositive];
    }
}

- (IBAction)onBtnLike:(id)sender {
    if ([self.delegate respondsToSelector:@selector(onTapMyLikes)]) {
        [self.delegate onTapMyLikes];
    }
}


@end
