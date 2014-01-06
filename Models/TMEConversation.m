#import "TMEConversation.h"


@interface TMEConversation ()

// Private interface goes here.

@end


@implementation TMEConversation

// Custom logic goes here.

+ (NSArray *)arrayConversationFromArrayData:(NSArray *)arrayData{
  NSMutableArray *arrayConversation = [@[] mutableCopy];
  for (NSDictionary *data in arrayData) {
    TMEConversation *conversation = [TMEConversation conversationFromData:data];
    [arrayConversation addObject:conversation];
  }
  
  return arrayConversation;
}

+ (TMEConversation *)conversationFromData:(NSDictionary *)data{
  TMEConversation *conversation = [[TMEConversation MR_findByAttribute:@"id" withValue:data[@"id"]] lastObject];
  
  if (conversation) {
    [conversation updateConversationWithData:data];
    return conversation;
  }
  
  conversation = [TMEConversation MR_createEntity];
  conversation.id = data[@"id"];
  conversation.user_id = data[@"user"][@"id"];
  conversation.user_full_name = data[@"user"][@"full_name"];
  if (![data[@"user"][@"facebook_avatar"] isKindOfClass:[NSNull class]]) {
    conversation.user_avatar = data[@"user"][@"facebook_avatar"];
  }
  
  TMEProduct *product = [[TMEProduct MR_findByAttribute:@"id" withValue:data[@"product_id"]] lastObject];
  conversation.product = product;
  
  if (![data[@"replies"] isKindOfClass:[NSNull class]]) {
    NSArray *arrayReplies = [TMEReply arrayRepliesFromArrayData:data[@"replies"] ofConversation:conversation];
    [conversation.repliesSet addObjectsFromArray:arrayReplies];
  }
  
  if (![data[@"lastest_message"] isKindOfClass:[NSNull class]]) {
    conversation.lastest_message = data[@"lastest_message"];
  }
  
  return conversation;
}

- (void)updateConversationWithData:(NSDictionary *)data{
  if (![data[@"replies"] isKindOfClass:[NSNull class]]) {
    [self.repliesSet removeAllObjects];
    NSArray *arrayReplies = [TMEReply arrayRepliesFromArrayData:data[@"replies"] ofConversation:self];
    [self.repliesSet addObjectsFromArray:arrayReplies];
  }
  
  if (![data[@"lastest_message"] isKindOfClass:[NSNull class]]) {
    self.lastest_message = data[@"lastest_message"];
  }
}

@end

