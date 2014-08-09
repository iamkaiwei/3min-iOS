//
//  TMEPusherManager.h
//  ThreeMin
//
//  Created by Bá Toàn on 3/24/14.
//
//


@interface TMEPusherManager : TMEBaseManager

OMNIA_SINGLETON_H(sharedInstance)


@property (strong, nonatomic) PTPusher * client;

+ (PTPusher *)getClient;
+ (void)connectWithDelegate:(id)delegate;
+ (void)authenticateUser;
+ (void)disconnect;
+ (PTPusherPresenceChannel *)subscribeToPresenceChannelNamed:(NSString *)name delegate:(id)delegate;
+ (PTPusherPrivateChannel *)subscribeToPrivateChannelNamed:(NSString *)name;
+ (PTPusherChannel *)subscribeToChannelNamed:(NSString *)name;

@end
