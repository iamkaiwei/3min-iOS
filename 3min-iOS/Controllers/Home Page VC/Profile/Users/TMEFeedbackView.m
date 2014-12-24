//
//  TMEFeedbackView.m
//  ThreeMin
//
//  Created by Vinh Nguyen on 24/12/2014.
//  Copyright (c) Năm 2014 3min. All rights reserved.
//

#import "TMEFeedbackView.h"
#import "TMEFeedback.h"

@interface TMEFeedbackView ()
@property (weak, nonatomic) IBOutlet KHRoundAvatar *feedbackUserAvatar;
@property (weak, nonatomic) IBOutlet UILabel *feedbackUserName;
@property (weak, nonatomic) IBOutlet UILabel *feedbackTime;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;
@end

@implementation TMEFeedbackView

#pragma mark - View Lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self customizeViews];
}

- (instancetype)init
{
    if (self = [super init]) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TMEFeedbackView class])
                                              owner:nil
                                            options:nil] firstObject];
    }
    
    return self;
}

#pragma mark - Private

- (void)customizeViews
{
    _viewFeedbackButton.layer.cornerRadius = 14.f;
    _viewFeedbackButton.layer.borderColor = [UIColor orangeMainColor].CGColor;
    _viewFeedbackButton.layer.borderWidth = 1.f;
    [_viewFeedbackButton addTarget:self
                            action:@selector(didTapViewFeedbackButton:)
                  forControlEvents:UIControlEventTouchDown];
}

- (void)setFeedback:(TMEFeedback *)feedback
{
    if (!feedback) {
        return;
    }
    
    [_feedbackUserAvatar setImageWithURL:[NSURL URLWithString:feedback.user.avatar]
                        placeholderImage:[UIImage imageNamed:@"avatar_holding"]];
    _feedbackUserName.text = feedback.user.fullName;
    _feedbackTime.text = feedback.updatedAt.agoString;
    _feedbackLabel.text = feedback.content;
}

#pragma mark - View Feedback Button

- (void)didTapViewFeedbackButton:(UIButton *)button
{
    if ([self.feedbackViewDelegate respondsToSelector:@selector(didTapViewFeedbackButton:)]) {
        [self.feedbackViewDelegate didTapViewFeedbackButton:button];
    }
}

@end
