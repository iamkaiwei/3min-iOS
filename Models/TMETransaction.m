#import "TMETransaction.h"


@interface TMETransaction ()

// Private interface goes here.

@end


@implementation TMETransaction

// Custom logic goes here.


+ (NSArray *)arrayTransactionFromArray:(NSArray *)arrData andProduct:(TMEProduct *)product withBuyer:(TMEUser *)buyer
{
    NSMutableArray *arrTrans = [@[] mutableCopy];
    for (NSDictionary *data in arrData) {
        TMETransaction *transaction = [TMETransaction transactionWithDictionary:data andProduct:product withBuyer:buyer];
        [arrTrans addObject:transaction];
    }
    
    return arrTrans;
}

+ (TMETransaction *)transactionWithDictionary:(NSDictionary *)data andProduct:(TMEProduct *)product withBuyer:(TMEUser *)buyer
{
    TMETransaction *transaction = [TMETransaction MR_createEntity];
    transaction.id = data[@"chat_id"];
    
    if ([data[@"message"] isEqual:[NSNull null]])
        transaction.chat = @"";
    else transaction.chat = data[@"message"];
    
    if ([data[@"from"] isEqualToNumber:product.user.id]) {
        transaction.from = product.user;
        transaction.to = buyer;
    }
    
    else
    {
        transaction.from = buyer;
        transaction.to = product.user;
    }
    transaction.product = [[TMEProduct MR_findByAttribute:@"id" withValue:data[@"product_id"]] lastObject];
    transaction.time_stamp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[data[@"sent_at"] doubleValue]];
    return transaction;
}

@end
