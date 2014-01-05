#import "TMEReply.h"


@interface TMEReply ()

// Private interface goes here.

@end


@implementation TMEReply

// Custom logic goes here.

+ (NSArray *)arrayMessageFromArray:(NSArray *)arrData andProduct:(TMEProduct *)product withBuyer:(TMEUser *)buyer
{
  NSMutableArray *arrTrans = [@[] mutableCopy];
  for (NSDictionary *data in arrData) {
    TMEReply *reply = [TMEReply replyWithData:data];
    [arrTrans addObject:reply];
  }

  return arrTrans;
}

+ (TMEReply *)replyWithData:(NSDictionary *)data{
  TMEReply *reply = [TMEReply MR_createEntity];
  
  reply.id = data[@"id"];
  reply.user_id = data[@"user_id"];
  reply.reply = data[@"reply"];
//  reply.time_stamp = nil;
//  reply.conversation = nil;
  
  return reply;
}

//+ (TMEMessage *)messagePendingWithContent:(NSString *)content
//{
//  TMEMessage *message = [TMEMessage MR_createEntity];
//
//  message.chat = content;
//  message.from = [[TMEUserManager sharedInstance] loggedUser];
//
//  return message;
//}

@end
