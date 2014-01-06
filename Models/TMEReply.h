#import "_TMEReply.h"

@interface TMEReply : _TMEReply {}
// Custom logic goes here.

+ (NSArray *)arrayRepliesFromArrayData:(NSArray *)arrData
                        ofConversation:(TMEConversation *)conversation;

+ (TMEReply *)replyWithData:(NSDictionary *)data
             ofConversation:(TMEConversation *)conversation;

+ (TMEReply *)replyPendingWithContent:(NSString *)content;

@end
