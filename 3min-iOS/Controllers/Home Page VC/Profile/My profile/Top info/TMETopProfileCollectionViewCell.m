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
@property (weak, nonatomic) IBOutlet UIButton *btnPositive;
@property (weak, nonatomic) IBOutlet UIButton *btnFollower;
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
}

@end
