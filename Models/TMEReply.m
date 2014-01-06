#import "TMEReply.h"


@interface TMEReply ()

// Private interface goes here.

@end


@implementation TMEReply

// Custom logic goes here.

+ (NSArray *)arrayRepliesFromArrayData:(NSArray *)arrData ofConversation:(TMEConversation *)conversation{
  NSMutableArray *arrReplies = [@[] mutableCopy];
  for (NSDictionary *data in arrData) {
    TMEReply *reply = [TMEReply replyWithData:data ofConversation:conversation];
    [arrReplies addObject:reply];
  }

  return arrReplies;
}

+ (TMEReply *)replyWithData:(NSDictionary *)data ofConversation:(TMEConversation *)conversation{
  TMEReply *reply = [TMEReply MR_createEntity];
  
  reply.id = data[@"id"];
  
  reply.user_id = conversation.user_id;
  reply.user_full_name = conversation.user_full_name;
  reply.user_avatar = conversation.user_avatar;
  
  reply.reply = data[@"reply"];
//  reply.time_stamp = nil;
  reply.conversation = conversation;
  
  return reply;
}

+ (TMEReply *)replyPendingWithContent:(NSString *)content
{
  TMEReply *reply = [TMEReply MR_createEntity];

  reply.reply = content;
  reply.user_avatar = [[[TMEUserManager sharedInstance] loggedUser] photo_url];
  reply.user_full_name = [[[TMEUserManager sharedInstance] loggedUser] fullname];
  reply.user_id = [[[TMEUserManager sharedInstance] loggedUser] id];

  return reply;
}

@end
