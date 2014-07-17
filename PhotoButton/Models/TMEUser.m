//
//  TMEUser.m
//  ThreeMin
//
//  Created by iSlan on 7/17/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEUser.h"

@implementation TMEUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"accessToken" : @"access_token",
             @"email" : @"email",
             @"facebookID" : @"facebook_id",
             @"fullName" : @"full_name",
             @"userID" : @"id",
             @"name" : @"",
             @"password" : @"",
             @"photoURL" : @"facebook_avatar",
             @"UDID" : @"udid",
             @"username" : @"username",
             @"activities" : @"",
             @"products" : @""
             };
}

+ (NSValueTransformer *)photoURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
