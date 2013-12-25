#import "TMETransaction.h"


@interface TMETransaction ()

// Private interface goes here.

@end


@implementation TMETransaction

// Custom logic goes here.


+ (NSArray *)arrayTransactionFromArray:(NSArray *)arrData andProduct:(TMEProduct *)product
{
    NSMutableArray *arrTrans = [@[] mutableCopy];
    for (NSDictionary *data in arrData) {
        TMETransaction *transaction = [TMETransaction transactionWithDictionary:data andProduct:product];
        [arrTrans addObject:transaction];
    }
    
    return arrTrans;
}

+ (TMETransaction *)transactionWithDictionary:(NSDictionary *)data andProduct:(TMEProduct *)product
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
    
    else
    {
//        [[TMEUserManager sharedInstance] getUserWithID:data[@"from"]
//                            onSuccess:^(TMEUser *userRes)
//         {
//             transaction.from = userRes;
//         }
//                           andFailure:^(NSInteger statusCode, NSError *error)
//         {
//             return;
//         }];
    }
    transaction.to = product.user;
    transaction.product = [[TMEProduct MR_findByAttribute:@"id" withValue:data[@"product_id"]] lastObject];
    transaction.time_stamp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[data[@"sent_at"] doubleValue]];
    return transaction;
}

@end
