#import "TMEReply.h"


@interface TMEReply ()

// Private interface goes here.

@end


@implementation TMEReply

// Custom logic goes here.

+ (NSArray *)arrayRepliesFromArrayData:(NSArray *)arrData ofConversation:(TMEConversation *)conversation{
    NSMutableArray *arrReplies = [@[] mutableCopy];
    NSNumber *largestID = [conversation.replies valueForKeyPath:@"@max.id"];
    for (NSDictionary *data in arrData) {
        TMEReply *reply = [TMEReply replyWithData:data ofConversation:conversation];
        if (!largestID) {
            largestID = @0;
        }
        NSComparisonResult result = [reply.id compare:largestID];
        if (result == NSOrderedDescending) {
            [arrReplies addObject:reply];
        }
    }
    
    return arrReplies;
}

+ (TMEReply *)replyWithData:(NSDictionary *)data ofConversation:(TMEConversation *)conversation{
    TMEReply *reply = [[TMEReply MR_findByAttribute:@"id" withValue:data[@"id"]] lastObject];
    
    if (!reply) {
        reply = [TMEReply MR_createEntity];
        reply.id = data[@"id"];
        reply.user_id = data[@"user_id"];
        reply.reply = data[@"reply"];
        if (![data[@"timestamp"] isKindOfClass:[NSNull class]]) {
            reply.time_stamp = [NSDate dateWithTimeIntervalSince1970:[data[@"timestamp"] doubleValue]];
        }
    }
    reply.conversation = conversation;
    
    return reply;
}

+ (TMEReply *)replyPendingWithContent:(NSString *)content
{
    TMEReply *reply = [TMEReply MR_createEntity];
    reply.reply = content;
    reply.user_avatar = [[[TMEUserManager sharedManager] loggedUser] avatar];
    reply.user_full_name = [[[TMEUserManager sharedManager] loggedUser] fullName];
    reply.user_id = [[[TMEUserManager sharedManager] loggedUser] userID];
    
    return reply;
}

+ (TMEReply *)replyWithContent:(NSString *)content sender:(TMEUser *)sender timeStamp:(NSNumber *)timeStamp
{
    TMEReply *reply = [TMEReply MR_createEntity];
    reply.reply = content;
    reply.user_avatar = sender.avatar;
    reply.user_full_name = sender.fullName;
    reply.user_id = sender.userID;
    reply.time_stamp = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];

    return reply;
}

@end
