#import "TMEMessage.h"


@interface TMEMessage ()

// Private interface goes here.

@end


@implementation TMEMessage

// Custom logic goes here.


+ (NSArray *)arrayMessageFromArray:(NSArray *)arrData andProduct:(TMEProduct *)product withBuyer:(TMEUser *)buyer
{
    NSMutableArray *arrTrans = [@[] mutableCopy];
    for (NSDictionary *data in arrData) {
        TMEMessage *message = [TMEMessage messageWithDictionary:data andProduct:product withBuyer:buyer];
        [arrTrans addObject:message];
    }
    
    return arrTrans;
}

+ (TMEMessage *)messageWithDictionary:(NSDictionary *)data andProduct:(TMEProduct *)product withBuyer:(TMEUser *)buyer
{
    TMEMessage *message = [TMEMessage MR_createEntity];
    message.id = data[@"chat_id"];
    
    if ([data[@"message"] isEqual:[NSNull null]])
        message.chat = @"";
    else message.chat = data[@"message"];
    
    if ([data[@"from"] isEqualToNumber:product.user.id]) {
        message.from = product.user;
        message.to = buyer;
    }
    
    else
    {
        message.from = buyer;
        message.to = product.user;
    }
    message.product = product;
    message.time_stamp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[data[@"sent_at"] doubleValue]];
    
    return message;
}

+ (TMEMessage *)messageWithContent:(NSString *)content andProduct:(TMEProduct *)product atTimestamp:(CGFloat)timestamp toUser:(TMEUser *)user
{
    TMEMessage *message = [TMEMessage MR_createEntity];
    message.chat = content;
    
    message.from = [[TMEUserManager sharedInstance] loggedUser];
    message.to = user;
    
    message.product = product;
    message.time_stamp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)timestamp];
    
    return message;
}

@end
