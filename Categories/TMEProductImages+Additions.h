//
//  TMEProductImages+Additions.h
//  PhotoButton
//
//  Created by Triệu Khang on 25/9/13.
//
//

#import "TMEProductImages.h"

@interface TMEProductImages (Additions)

+ (TMEProductImages *)productImageFromDictionary:(NSDictionary *)data;
+ (NSArray *)productImagesFromArray:(NSArray *)arrayData;
+ (NSSet *)productImagesSetFromArray:(NSArray *)arrayData;

@end
