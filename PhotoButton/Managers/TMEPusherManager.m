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

@end

@implementation TMEPusherManager

SINGLETON_MACRO

+ (PTPusher *)getClient{
    return [TMEPusherManager sharedInstance].client;
}

+ (void)connectWithDelegate:(id)delegate{
    [TMEPusherManager sharedInstance].client = [PTPusher pusherWithKey:PUSHER_APP_KEY delegate:delegate encrypted:YES];
    [TMEPusherManager authenticateUser];
    [[TMEPusherManager getClient] connect];
}

+ (void)authenticateUser{
    NSURL *authorizationURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", API_SERVER_HOST, API_PREFIX, URL_PUSHER_ENDPOINT]];
    [TMEPusherManager getClient].authorizationURL = authorizationURL;
}

+ (void)disconnect{
    [[TMEPusherManager getClient] disconnect];
}

+ (PTPusherPresenceChannel *)subscribeToPresenceChannelNamed:(NSString *)name delegate:(id)delegate{
    return [[TMEPusherManager getClient] subscribeToPresenceChannelNamed:name delegate:delegate];
}

+ (PTPusherPrivateChannel *)subscribeToPrivateChannelNamed:(NSString *)name{
    return [[TMEPusherManager getClient] subscribeToPrivateChannelNamed:name];
}

+ (PTPusherChannel *)subscribeToChannelNamed:(NSString *)name{
    return [[TMEPusherManager getClient] subscribeToChannelNamed:name];
}

@end
