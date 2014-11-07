//
//  TMEPusherImp.h
//  ThreeMin
//
//  Created by iSlan on 11/5/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMEPusherImp : NSObject <PTPusherDelegate, PTPusherPresenceChannelDelegate>

@property (copy, nonatomic) void (^memberRemovedHandleBlock)();

- (instancetype)initWithCurrentPostMode:(TMEPostMode)postMode activeChannel:(PTPusherChannel *)channel;

@end