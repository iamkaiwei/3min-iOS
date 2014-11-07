//
//  TMEUserMessageParameter.m
//  ThreeMin
//
//  Created by iSlan on 11/5/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEUserMessageParameter.h"

@implementation TMEUserMessageParameter
@synthesize page = _page,
            latestReplyID = _latestReplyID,
            smallerReplyID = _smallerReplyID,
            conversationID = _conversationID,
            user = _user,
            presenceChannel = _presenceChannel,
            message = _message,
            postMode = _postMode,
            shouldPostMessageBlock = _shouldPostMessageBlock,
            didPostMessageBlock = _didPostMessageBlock,
            postMessageFailedBlock = _postMessageFailBlock;

- (instancetype)initWithMessage:(NSString *)message ofUser:(TMEUser *)user presenceChannel:(PTPusherPresenceChannel *)channel latestReplyID:(NSInteger)latestReplyID conversationID:(NSNumber *)conversationID postMode:(TMEPostMode)postMode
{
    if (self = [super init]) {
        _message = message;
        _user = user;
        _presenceChannel = channel;
        _latestReplyID = latestReplyID;
        _conversationID = conversationID;
        _postMode = postMode;
    }
    return self;
}

- (instancetype)initWithLatestReplyID:(NSInteger)latestReplyID conversationID:(NSNumber *)conversationID smallerReplyID:(NSInteger)smallerReplyID page:(NSInteger)page
{
    if (self = [self initWithMessage:nil ofUser:nil presenceChannel:nil latestReplyID:latestReplyID conversationID:conversationID postMode:0]) {
        _smallerReplyID = smallerReplyID;
        _page = page;
    }
    return self;
}
@end
