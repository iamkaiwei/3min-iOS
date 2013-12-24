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
    
    transaction.from = [[TMEUser MR_findByAttribute:@"id" withValue:data[@"from"]] lastObject];
    transaction.to = [[TMEUser MR_findByAttribute:@"id" withValue:data[@"to"]] lastObject];
    transaction.product = [[TMEProduct MR_findByAttribute:@"id" withValue:data[@"product_id"]] lastObject];
    
    transaction.time_stamp = data[@"sent_at"];
    return transaction;
}
@end
