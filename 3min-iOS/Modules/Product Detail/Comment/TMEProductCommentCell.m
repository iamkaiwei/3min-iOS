//
//  TMEProductCommentCell.m
//  ThreeMin
//
//  Created by Khoa Pham on 10/6/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductCommentCell.h"
#import "TMEProductComment.h"
#import <QuartzCore/QuartzCore.h>
#import "KHRoundAvatar.h"

@interface TMEProductCommentCell ()

@property (weak, nonatomic) IBOutlet KHRoundAvatar *userAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

@implementation TMEProductCommentCell

- (void)awakeFromNib {
}

- (void)updatePreferredMaxLayoutWidth
{
    self.userNameLabel.preferredMaxLayoutWidth = self.userNameLabel.width;
    self.commentLabel.preferredMaxLayoutWidth = self.commentLabel.width;
}

- (void)configureForModel:(TMEProductComment *)comment
{
    [self.userAvatarImageView setImageWithURL:[NSURL URLWithString:comment.user.avatar] placeholderImage:nil];
    self.userNameLabel.text = comment.user.fullName;
    self.commentLabel.text = comment.content;
}

@end
