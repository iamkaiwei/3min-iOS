#import "_TMEMessage.h"

@interface TMEMessage : _TMEMessage {}
// Custom logic goes here.

+ (NSArray *)arrayMessageFromArray:(NSArray *)arrData
                        andProduct:(TMEProduct *)product
                         withBuyer:(TMEUser *)buyer;

+ (TMEMessage *)messageWithDictionary:(NSDictionary *)data
                           andProduct:(TMEProduct *)product
                            withBuyer:(TMEUser *)buyer;

+ (TMEMessage *)messagePendingWithContent:(NSString *)content;

@end
