#import "TMEReply.h"

@implementation TMEReply

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"replyID": @"id",
             @"reply": @"reply",
             @"timeStamp": @"timestamp",
             @"userAvatar": [NSNull null],
             @"userFullName": [NSNull null],
             @"userID": @"user_id",
             @"conversation": [NSNull null],
             };
}

+ (NSValueTransformer *)timeStampJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *timestamp) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timestamp integerValue]];
        return date;
    } reverseBlock:^(NSDate *date) {
        return @([date timeIntervalSince1970]);
    }];
}

@end
