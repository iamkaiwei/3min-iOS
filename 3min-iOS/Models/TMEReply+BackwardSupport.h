//
//  TMEReply+BackwardSupport.h
//  ThreeMin
//
//  Created by iSlan on 10/29/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEReply.h"

@interface TMEReply (BackwardSupport)

+ (TMEReply *)replyPendingWithContent:(NSString *)content;
+ (TMEReply *)replyWithContent:(NSString *)content sender:(TMEUser *)sender timeStamp:(NSNumber *)timeStamp;

@end
