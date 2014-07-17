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

    return [MTLJSONAdapter modelsOfClass:[TMEProduct class] fromJSONArray:responseObject error:NULL];
}

@end
