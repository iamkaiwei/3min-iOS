//
//  TMEConversation.m
//  ThreeMin
//
//  Created by Triệu Khang on 20/7/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEConversation.h"

@implementation TMEConversation

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error
{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self) {
        for (TMEReply *reply in self.replies) {
            reply.conversation = self;
        }
    }
    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"channelName": @"channel_name",
             @"userAvatar": @"user.facebook_avatar",
             @"userFullname": @"user.full_name",
             @"userID": @"user.id",
             @"conversationID": @"id",
             @"latestUpdate": @"latest_update",
             @"latestMessage": @"latest_message",
             @"offer": @"offer",
             @"replies": @"replies"
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

+ (NSValueTransformer *)repliesJSONTransformer {
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[TMEReply class]];
}

@end
