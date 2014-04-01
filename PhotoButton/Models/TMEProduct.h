#import "_TMEProduct.h"

@interface TMEProduct : _TMEProduct {}
// Custom logic goes here.
+ (TMEProduct *)productWithDictionary:(NSDictionary *)data;
+ (NSArray *)arrayProductsFromArray:(NSArray *)arrData;
+ (NSArray *)arrayProductsFromArray:(NSArray *)arrData liked:(BOOL)liked;

@end
