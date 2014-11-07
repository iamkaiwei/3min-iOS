//
//  TMEPusherImp.m
//  ThreeMin
//
//  Created by iSlan on 11/5/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEPusherImp.h"

@interface TMEPusherImp ()

@property (assign, nonatomic) TMEPostMode postMode;
@property (strong, nonatomic) PTPusherChannel *channel;

@end

@implementation TMEPusherImp

- (instancetype)initWithCurrentPostMode:(TMEPostMode)postMode activeChannel:(PTPusherChannel *)channel
{
    if (self = [super init]) {
        _postMode = postMode;
        _channel = channel;
    }
    return self;
}

- (void)pusher:(PTPusher *)pusher willAuthorizeChannel:(PTPusherChannel *)channel withRequest:(NSMutableURLRequest *)request{
    [request setValue:[NSString stringWithFormat:@"Bearer %@",[TMEUserManager sharedManager].loggedUser.accessToken] forHTTPHeaderField:@"Authorization"];
}

- (void)presenceChannelDidSubscribe:(PTPusherPresenceChannel *)channel{
    if (channel.members.count == 2) {
        self.postMode = TMEPostModeOnline;
    };
}

- (void)presenceChannel:(PTPusherPresenceChannel *)channel memberAdded:(PTPusherChannelMember *)member{
    self.postMode = TMEPostModeOnline;
    [TSMessage showNotificationWithTitle:[NSString stringWithFormat:@"%@ is online!", member.userInfo[@"name"]] type:TSMessageNotificationTypeSuccess];
}

- (void)presenceChannel:(PTPusherPresenceChannel *)channel memberRemoved:(PTPusherChannelMember *)member{
    self.postMode = TMEPostModeOffline;
    if (self.memberRemovedHandleBlock) {
        self.memberRemovedHandleBlock();
    }
}

@end
