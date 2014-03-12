#import "_TMEProductImages.h"

@interface TMEProductImages : _TMEProductImages {}
// Custom logic goes here.
+ (TMEProductImages *)productImageFromDictionary:(NSDictionary *)data;
+ (NSArray *)productImagesFromArray:(NSArray *)arrayData;
+ (NSSet *)productImagesSetFromArray:(NSArray *)arrayData;

@end
