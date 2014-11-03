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
             @"expiresIn" : @"expires_in",
             @"tokenType" : @"token_type",
             @"facebookID" : @"facebook_id",
             @"facebookAvatar" : @"facebook_avatar",
             @"googleID" : @"google_id",
             @"userID" : @"id",
             @"userUDID" : @"udid",
             @"username" : @"username",
             @"avatar" : @"avatar",
             @"birthday" : @"birthday",
             @"email" : @"email",
             @"firstName" : @"first_name",
             @"fullName" : @"full_name",
             @"lastName" : @"last_name",
             @"middleName" : @"middle_name",
             @"gender" : @"gender",
             @"role" : @"role",
             @"accessTokenReceivedAt": NSNull.null,
             };
}

+ (NSValueTransformer *)birthdayJSONTransformer
{
    // FIXME: birthday is still nil
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *birthdayString) {
        return [[self dateTimeFormatter] dateFromString:birthdayString];
    } reverseBlock:^(NSDate *birthday) {
        return [[self dateTimeFormatter] stringFromDate:birthday];
    }];
}

#pragma mark - Helper
+ (NSDateFormatter *)dateTimeFormatter {
	static NSDateFormatter *dateTimeFormatter = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    dateTimeFormatter = [[NSDateFormatter alloc] init];
	    [dateTimeFormatter setDateFormat:@"dd-MM-yyyy"];
	});

    return dateTimeFormatter;
}


@end
