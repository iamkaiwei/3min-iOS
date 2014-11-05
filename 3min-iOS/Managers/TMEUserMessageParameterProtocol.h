//
//  TMEUserMessageParameterProtocol.h
//  ThreeMin
//
//  Created by iSlan on 11/5/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMEUserMessageParameter.h"

@protocol TMEUserMessageParameterProtocol <NSObject>

@property (strong, nonatomic) PTPusherPresenceChannel *presenceChannel;
@property (strong, nonatomic) TMEUser *user;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSNumber *conversationID;
@property (assign, nonatomic) NSInteger latestReplyID;
@property (assign, nonatomic) TMEPostMode postMode;
@property (copy, nonatomic) void (^shouldPostMessageBlock)(TMEReply *reply, TMEPostMode currentPostMode);
@property (copy, nonatomic) void (^didPostMessageBlock)();
@property (copy, nonatomic) void (^postMessageFailedBlock)(NSError *error);

- (instancetype)initWithMessage:(NSString *)message ofUser:(TMEUser *)user presenceChannel:(PTPusherPresenceChannel *)channel latestReplyID:(NSInteger)latestReplyID conversationID:(NSNumber *)conversationID postMode:(TMEPostMode)postMode;

@end
