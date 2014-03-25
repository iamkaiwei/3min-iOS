//
//  TMEPusherManager.m
//  ThreeMin
//
//  Created by Bá Toàn on 3/24/14.
//
//

#import "TMEPusherManager.h"
#import <PTPusherEvent.h>
#import <PTPusherChannel.h>

@interface TMEPusherManager()
<PTPusherDelegate>

@end

@implementation TMEPusherManager

SINGLETON_MACRO

+ (PTPusher *)getClient{
    return [TMEPusherManager sharedInstance].client;
}

+ (void)connectWithDelegate:(id)delegate{
    [TMEPusherManager sharedInstance].client = [PTPusher pusherWithKey:PUSHER_APP_KEY delegate:delegate encrypted:YES];
}

+ (void)authenticateUser{
    [TMEPusherManager getClient].authorizationURL = [NSURL URLWithString:API_SERVER_HOST];
}

+ (PTPusherPresenceChannel *)subscribeToPresenceChannelNamed:(NSString *)name{
    return [[TMEPusherManager getClient] subscribeToPresenceChannelNamed:name];
}

+ (PTPusherPrivateChannel *)subscribeToPrivateChannelNamed:(NSString *)name{
    return [[TMEPusherManager getClient] subscribeToPrivateChannelNamed:name];
}

+ (PTPusherChannel *)subscribeToChannelNamed:(NSString *)name{
    return [[TMEPusherManager getClient] subscribeToChannelNamed:name];
}

- (void)pusher:(PTPusher *)pusher willAuthorizeChannel:(PTPusherChannel *)channel withRequest:(NSMutableURLRequest *)request{
    [request setValue:[[TMEUserManager sharedInstance] getAccessToken] forHTTPHeaderField:@"Authorization: Bearer"];
}

@end
