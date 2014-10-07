//
//  TMEProductLikeCell.m
//  ThreeMin
//
//  Created by Khoa Pham on 10/6/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductLikeCell.h"
#import <QuartzCore/QuartzCore.h>
#import "KHRoundAvatar.h"

@interface TMEProductLikeCell ()
@property (weak, nonatomic) IBOutlet KHRoundAvatar *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation TMEProductLikeCell

- (void)awakeFromNib {

}

- (void)configureForModel:(TMEUser *)user
{
    self.userNameLabel.text = user.fullName;
    [self.userImageView setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:nil];
}

@end
