//
//  TMEProductLikeCell.m
//  ThreeMin
//
//  Created by Khoa Pham on 10/6/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductLikeCell.h"

@interface TMEProductLikeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;


@end

@implementation TMEProductLikeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configureForModel:(TMEUser *)user
{
    self.userNameLabel.text = user.fullName;
    [self.userImageView setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:nil];
}

@end
