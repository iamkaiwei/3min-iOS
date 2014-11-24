//
//  TMEFeedbackCell.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/22/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEFeedbackCell.h"
#import "TMEFeedback.h"

@implementation TMEFeedbackCell

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];

    self.contentView.frame = self.bounds;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];

    self.feedbackLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.feedbackLabel.frame);
}

- (void)configureForModel:(TMEFeedback *)feedback
{
    [self.userImageView setImageWithURL:[NSURL URLWithString:feedback.user.avatar] placeholderImage:nil];
    self.userNameLabel.text = feedback.user.fullName;
    self.feedbackLabel.text = feedback.content;
    self.dateLabel.text = feedback.updatedAt.agoString;
}

@end
