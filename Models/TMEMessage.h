#import "_TMETransaction.h"

@interface TMEMessage : _TMETransaction {}
// Custom logic goes here.


+ (NSArray *)arrayMessageFromArray:(NSArray *)arrData
                            andProduct:(TMEProduct *)product
                             withBuyer:(TMEUser *)buyer;

+ (TMEMessage *)messageWithDictionary:(NSDictionary *)data
                                   andProduct:(TMEProduct *)product
                                    withBuyer:(TMEUser *)buyer;

+ (TMEMessage *)messageWithContent:(NSString *)content
                                andProduct:(TMEProduct *)product
                               atTimestamp:(CGFloat)timestamp
                                 toUser:(TMEUser *)user;

@end
