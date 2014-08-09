//
//  TMEUser.m
//  ThreeMin
//
//  Created by iSlan on 7/17/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEUser.h"
#import "TMEActivity.h"

@implementation TMEUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"accessToken" : @"access_token",
             @"email" : @"email",
             @"facebookID" : @"facebook_id",
             @"fullName" : @"full_name",
             @"userID" : @"id",
             @"password" : @"encrypted_password",
             @"photoURL" : @"avatar",
             @"UDID" : @"udid",
             @"username" : @"username",
             @"birthday" : @"birthday",
             @"googleID" : @"google_id",
             @"activities" : @"activities",
             @"products" : @"products"
             };
}

+ (NSDateFormatter *)dateTimeFormatter {
	static NSDateFormatter *dateTimeFormatter = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    dateTimeFormatter = [[NSDateFormatter alloc] init];
	    [dateTimeFormatter setDateFormat:@"dd-MM-yyyy"];
	});

    return dateTimeFormatter;
}

+ (NSValueTransformer *)photoURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)productsJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[TMEProduct class]];
}

+ (NSValueTransformer *)activitiesJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[TMEActivity class]];
}

+ (NSValueTransformer *)birthdayJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *birthdayString) {
        return [[self dateTimeFormatter] dateFromString:birthdayString];
    } reverseBlock:^(NSDate *birthday) {
        return [[self dateTimeFormatter] stringFromDate:birthday];
    }];
}

@end
