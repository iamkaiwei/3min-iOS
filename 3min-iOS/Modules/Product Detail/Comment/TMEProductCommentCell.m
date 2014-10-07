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
#import <FormatterKit/TTTTimeIntervalFormatter.h>

@interface TMEProductCommentCell ()

@property (weak, nonatomic) IBOutlet KHRoundAvatar *userAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation TMEProductCommentCell

- (void)awakeFromNib {
}

- (void)updatePreferredMaxLayoutWidth
{
    self.commentLabel.preferredMaxLayoutWidth = self.commentLabel.width;
}

- (void)configureForModel:(TMEProductComment *)comment
{
    [self.userAvatarImageView setImageWithURL:[NSURL URLWithString:comment.user.avatar] placeholderImage:nil];
    self.commentLabel.text = comment.content;

    TTTTimeIntervalFormatter *timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
    self.dateLabel.text = [timeIntervalFormatter stringForTimeInterval:comment.updatedAt.timeIntervalSinceNow];
}


@end
