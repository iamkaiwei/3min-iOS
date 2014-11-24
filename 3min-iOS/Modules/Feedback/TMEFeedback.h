//
//  TMEFeedback.h
//  ThreeMin
//
//  Created by Khoa Pham on 11/22/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEBaseModel.h"

typedef NS_ENUM(NSUInteger, TMEFeedbackStatus) {
    TMEFeedbackStatusUnknown,
    TMEFeedbackStatusNegative,
    TMEFeedbackStatusPositive,
};

@interface TMEFeedback : TMEBaseModel

@property (nonatomic, strong) NSNumber *feedbackID;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) TMEUser *user;
@property (nonatomic, strong) NSDate *updatedAt;
@property (nonatomic, assign) TMEFeedbackStatus feedbackStatus;

@end
