#import "TMETransaction.h"


@interface TMETransaction ()

// Private interface goes here.

@end


@implementation TMETransaction

// Custom logic goes here.


+ (NSArray *)arrayTransactionFromArray:(NSArray *)arrData
{
    NSMutableArray *arrTrans = [@[] mutableCopy];
    for (NSDictionary *data in arrData) {
        TMETransaction *transaction = [TMETransaction transactionWithDictionary:data];
        [arrTrans addObject:transaction];
    }
    
    return arrTrans;
}

+ (TMETransaction *)transactionWithDictionary:(NSDictionary *)data
{
    TMETransaction *transaction = [TMETransaction MR_createEntity];
    transaction.id = data[@"chat_id"];
    
    if ([data[@"message"] isEqual:[NSNull null]])
        transaction.chat = @"";
    else transaction.chat = data[@"message"];

    NSNumber *logid = [[TMEUserManager sharedInstance] loggedUser].id;
    if ([data[@"from"] isEqualToNumber:logid]) {
        transaction.from = [[TMEUserManager sharedInstance] loggedUser];
    }
    
    transaction.product = [[TMEProduct MR_findByAttribute:@"id" withValue:data[@"product_id"]] lastObject];
    transaction.time_stamp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[data[@"sent_at"] doubleValue]];
    return transaction;
}

@end
