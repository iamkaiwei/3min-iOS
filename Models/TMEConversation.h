#import "_TMEConversation.h"

@interface TMEConversation : _TMEConversation {}
// Custom logic goes here.

+ (NSArray *)arrayConversationFromArrayData:(NSArray *)arrayData;
+ (TMEConversation *)conversationFromData:(NSDictionary *)data;

@end
