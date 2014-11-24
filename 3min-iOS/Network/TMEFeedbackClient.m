//
//  TMEFeedbackClient.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/22/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEFeedbackClient.h"
#import "TMEFeedback.h"

@implementation TMEFeedbackClient

+ (void)getFeedbacksForUser:(TMEUser *)user success:(TMEArrayBlock)success failure:(TMEFailureBlock)failure
{
    NSString *path = NSStringf(@"%@", API_FEEDBACK);
    NSDictionary *params = @{@"user_id": user.userID,
                             };

    [[TMENetworkManager sharedManager] get:path params:params success:^(id responseObject) {
        NSArray *feedbacks = [TMEFeedback tme_modelsFromJSONResponse:responseObject];
        if (success) {
            success(feedbacks);
        }
    } failure:failure];
}

@end
