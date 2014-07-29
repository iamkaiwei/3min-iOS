//
//  TMEConversation.m
//  ThreeMin
//
//  Created by Triệu Khang on 20/7/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEConversation.h"

@implementation TMEConversation

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"channelName": @"channel_name",
             @"userAvatar": @"user.facebook_avatar",
             @"userFullname": @"user.full_name",
             @"userID": @"user.id",
             @"id": @"id",
             @"latestUpdate": @"latest_update",
             @"latestMessage": @"latest_message",
             @"offer": @"offer",
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

+ (NSValueTransformer *)latestMessageJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *birthdayString) {
        return [[self dateTimeFormatter] dateFromString:birthdayString];
    } reverseBlock:^(NSDate *birthday) {
        return [[self dateTimeFormatter] stringFromDate:birthday];
    }];
}

+ (NSValueTransformer *)productMessageJSONTransformer {
    return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TMEProduct class]];
}

@end
