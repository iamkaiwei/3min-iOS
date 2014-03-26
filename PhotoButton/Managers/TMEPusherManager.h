//
//  TMEPusherManager.h
//  ThreeMin
//
//  Created by Bá Toàn on 3/24/14.
//
//

#import "BaseManager.h"

@interface TMEPusherManager : BaseManager

@property (strong, nonatomic) PTPusher * client;

+ (PTPusher *)getClient;
+ (void)connectWithDelegate:(id)delegate;
+ (void)authenticateUser;
+ (void)bindingWithChannel:(PTPusherChannel *)channel;
+ (void)disconnect;
+ (PTPusherPresenceChannel *)subscribeToPresenceChannelNamed:(NSString *)name delegate:(id)delegate;
+ (PTPusherPresenceChannel *)subscribeToSelfPresenceChannel;
+ (PTPusherPrivateChannel *)subscribeToPrivateChannelNamed:(NSString *)name;
+ (PTPusherChannel *)subscribeToChannelNamed:(NSString *)name;

@end
