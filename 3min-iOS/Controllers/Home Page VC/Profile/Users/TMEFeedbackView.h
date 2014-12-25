//
//  TMEFeedbackView.h
//  ThreeMin
//
//  Created by Vinh Nguyen on 24/12/2014.
//  Copyright (c) Năm 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMEFeedback;
@protocol TMEFeedbackViewDelegate <NSObject>
@optional
- (void)didTapViewFeedbackButton:(UIButton *)button;
@end

@interface TMEFeedbackView : UIView
@property (nonatomic, strong) TMEFeedback *feedback;
@property (nonatomic, weak) id<TMEFeedbackViewDelegate> feedbackViewDelegate;
@property (weak, nonatomic) IBOutlet UIButton *viewFeedbackButton;
@property (weak, nonatomic) IBOutlet UIView *feedbackView;
@end
