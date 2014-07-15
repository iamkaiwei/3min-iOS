//
//  TMEProduct+ParseArrayProducts.m
//  ThreeMin
//
//  Created by Triệu Khang on 15/7/14.
//
//

#import "TMEProduct+ParseArrayProducts.h"

@implementation TMEProduct (ParseArrayProducts)

+ (NSArray *)arrayProductsFromArray:(NSArray *)responseObject {
    return [responseObject rx_mapWithBlock:^TMEProduct *(NSDictionary *info) {
        return [TMEProduct modelWithDictionary:info error:nil];
    }];
}

@end
