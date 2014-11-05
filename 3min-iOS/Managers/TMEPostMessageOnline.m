//
//  TMEPostMessageOnline.m
//  ThreeMin
//
//  Created by iSlan on 11/5/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEPostMessageOnline.h"
#import "TMEUserMessage.h"

@implementation TMEPostMessageOnline

+ (void)postMessageWithParameter:(TMEUserMessageParameter *)parameter {
    CGFloat currentTimeStamp = [[NSDate date] timeIntervalSince1970];
    TMEReply *reply = [TMEReply replyWithContent:parameter.message
                                          sender:parameter.user
                                       timeStamp:@(currentTimeStamp)];
    [parameter.presenceChannel triggerEventNamed:PUSHER_CHAT_EVENT_NAME
                                       data:@{@"name": parameter.user.fullName,
                                              @"message" : parameter.message,
                                              @"timestamp" : @(currentTimeStamp)}];
    if (parameter.shouldPostMessageBlock) {
        parameter.shouldPostMessageBlock(reply, parameter.postMode);
    }
}

@end
