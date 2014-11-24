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

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation TMEProductCommentCell

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

    self.commentLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.commentLabel.frame);
}

- (void)configureForModel:(TMEProductComment *)comment
{
    [self.userAvatarImageView setImageWithURL:[NSURL URLWithString:comment.user.avatar] placeholderImage:nil];

    [self configureCommentLabel:comment.user.fullName content:comment.content];
    [self configureDateLabel:comment.updatedAt];
}

#pragma mark - Helper
- (void)configureDateLabel:(NSDate *)date
{
    self.dateLabel.text = date.agoString;
}

- (void)configureCommentLabel:(NSString *)userName content:(NSString *)content
{

    NSString *text = NSStringf(@"%@  %@", userName, content);
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor redColor],
                                 };
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedText addAttributes:attributes range:NSMakeRange(0, userName.length)];

    self.commentLabel.attributedText = attributedText;
}


@end
