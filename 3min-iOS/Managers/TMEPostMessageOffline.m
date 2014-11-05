//
//  TMEPostMessageOffline.m
//  ThreeMin
//
//  Created by iSlan on 11/5/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEPostMessageOffline.h"
#import "TMEUserMessage.h"

@implementation TMEPostMessageOffline

+ (void)postMessageWithParameter:(TMEUserMessageParameter *)parameter {
    TMEReply *reply = [TMEReply replyPendingWithContent:parameter.message];
    if (parameter.shouldPostMessageBlock) {
        parameter.shouldPostMessageBlock(reply, parameter.postMode);
    }
    [TMEConversationManager postReplyToConversation:[parameter.conversationID integerValue]
                                        withMessage:parameter.message
                                     onSuccessBlock:^(NSString *status)
     {
         if ([status isEqualToString:@"success"]) {
             if (parameter.didPostMessageBlock) {
                 parameter.didPostMessageBlock();
             }
         }
     }
                                       failureBlock:^(NSError *error)
     {
         if (parameter.postMessageFailedBlock) {
             parameter.postMessageFailedBlock(error);
         }
     }];
}

@end
