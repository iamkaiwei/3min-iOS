//
//  TMEProduct+Additions.h
//  PhotoButton
//
//  Created by Triệu Khang on 25/9/13.
//
//

#import "TMEProduct.h"

@interface TMEProduct (Additions)

+ (TMEProduct *)productWithDictionary:(NSDictionary *)data;
+ (NSArray *)arrayProductsFromArray:(NSArray *)arrData;

@end
