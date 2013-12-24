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
    
    return transaction;
}
@end
