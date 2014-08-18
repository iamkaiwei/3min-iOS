//
//  TMEUser+BackwardSupport.m
//  ThreeMin
//
//  Created by iSlan on 7/17/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEUser+BackwardSupport.h"

@implementation TMEUser (BackwardSupport)

+ (TMEUser *)userWithID:(NSNumber *)ID fullName:(NSString *)fullName photoURL:(NSString *)photoURL
{
    TMEUser *user = [[TMEUser alloc] init];
    user.userID = ID;
    user.avatar = photoURL;
    user.fullName = fullName;
    
    return user;
}


@end
