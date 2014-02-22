#import "_TMEConversation.h"

@interface TMEConversation : _TMEConversation {}
// Custom logic goes here.

+ (NSArray *)arrayConversationFromArrayData:(NSArray *)arrayData;
+ (NSArray *)arrayConversationFromOfferArrayData:(NSArray *)arrayData;
+ (TMEConversation *)conversationFromData:(NSDictionary *)data;

@end
