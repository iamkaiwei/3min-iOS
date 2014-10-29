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

//+ (TMEReply *)replyPendingWithContent:(NSString *)content
//{
//    TMEReply *reply = [TMEReply MR_createEntity];
//    reply.reply = content;
//    reply.user_avatar = [[[TMEUserManager sharedManager] loggedUser] avatar];
//    reply.user_full_name = [[[TMEUserManager sharedManager] loggedUser] fullName];
//    reply.user_id = [[[TMEUserManager sharedManager] loggedUser] userID];
//    
//    return reply;
//}

//+ (TMEReply *)replyWithContent:(NSString *)content sender:(TMEUser *)sender timeStamp:(NSNumber *)timeStamp
//{
//    TMEReply *reply = [TMEReply MR_createEntity];
//    reply.reply = content;
//    reply.user_avatar = sender.avatar;
//    reply.user_full_name = sender.fullName;
//    reply.user_id = sender.userID;
//    reply.time_stamp = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
//
//    return reply;
//}

@end
