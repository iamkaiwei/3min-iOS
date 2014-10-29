//
//  TMEReply+BackwardSupport.m
//  ThreeMin
//
//  Created by iSlan on 10/29/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEReply+BackwardSupport.h"

@implementation TMEReply (BackwardSupport)

+ (TMEReply *)replyPendingWithContent:(NSString *)content
{
    TMEReply *reply = [[TMEReply alloc] init];
    reply.reply = content;
    reply.userAvatar = [[[TMEUserManager sharedManager] loggedUser] avatar];
    reply.userFullName = [[[TMEUserManager sharedManager] loggedUser] fullName];
    reply.userID = [[[TMEUserManager sharedManager] loggedUser] userID];

    return reply;
}

+ (TMEReply *)replyWithContent:(NSString *)content sender:(TMEUser *)sender timeStamp:(NSNumber *)timeStamp
{
    TMEReply *reply = [[TMEReply alloc] init];
    reply.reply = content;
    reply.userAvatar = sender.avatar;
    reply.userFullName = sender.fullName;
    reply.userID = sender.userID;
    reply.timeStamp = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];

    return reply;
}

@end
