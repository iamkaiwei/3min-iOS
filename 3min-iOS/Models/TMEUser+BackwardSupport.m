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
    // The dictionary is fagmented so we have to merge before parsing it
    NSMutableDictionary *userDict = [data[@"user"] mutableCopy];
    userDict[@"access_token"] = data[@"access_token"];
    
    NSError *error;
    TMEUser *user = [MTLJSONAdapter modelOfClass:[TMEUser class] fromJSONDictionary:userDict error:&error];
    return user;
}

+ (TMEUser *)userWithID:(NSNumber *)ID fullName:(NSString *)fullName photoURL:(NSString *)photoURL
{
    TMEUser *user = [[TMEUser alloc] init];
    user.userID = ID;
    user.photoURL = [NSURL URLWithString:photoURL];
    user.fullName = fullName;
    
    return user;
}

- (NSNumber *)id {
    return self.userID;
}

- (void)setId:(NSNumber *)ID {
    self.userID = ID;
}

- (NSString *)fullname {
    return self.fullName;
}

- (NSString *)photo_url {
    return [self.photoURL absoluteString];
}

- (NSString *)access_token {
    return self.accessToken;
}

- (void)setAccess_token:(NSString *)accessToken {
    self.accessToken = accessToken;
}

- (NSString *)facebook_id {
    return self.facebookID;
}

- (NSString *)name {
    return self.fullName;
}

- (void)setName:(NSString *)name {
    self.fullName = name;
}

@end
