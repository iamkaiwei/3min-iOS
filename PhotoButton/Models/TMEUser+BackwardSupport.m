//
//  TMEUser+BackwardSupport.m
//  ThreeMin
//
//  Created by iSlan on 7/17/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEUser+BackwardSupport.h"

@implementation TMEUser (BackwardSupport)

+ (TMEUser *)userWithData:(id)data{
    return [MTLJSONAdapter modelOfClass:[TMEUser class] fromJSONDictionary:data error:NULL];
}

+ (TMEUser *)userByFacebookDictionary:(NSDictionary *)data{
    return [MTLJSONAdapter modelOfClass:[TMEUser class] fromJSONDictionary:data error:NULL];
}

+ (TMEUser *)userWithID:(NSNumber *)ID fullName:(NSString *)fullName photoURL:(NSString *)photoURL
{
    TMEUser *user = [[TMEUser alloc] init];
    user.userID = ID;
    user.photoURL = [NSURL URLWithString:photoURL];
    user.fullName = fullName;
    
    return user;
}

@end
