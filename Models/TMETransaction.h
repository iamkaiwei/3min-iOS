#import "_TMETransaction.h"

@interface TMETransaction : _TMETransaction {}
// Custom logic goes here.


+ (NSArray *)arrayTransactionFromArray:(NSArray *)arrData andProduct:(TMEProduct *)product;
+ (TMETransaction *)transactionWithDictionary:(NSDictionary *)data andProduct:(TMEProduct *)product;

@end
