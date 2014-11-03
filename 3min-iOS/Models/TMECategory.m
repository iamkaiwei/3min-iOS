//
//  TMECategory.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/5/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMECategory.h"
#import "TMEImage.h"

@implementation TMECategory

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"categoryId" : @"id",
             @"specificType": @"specific_type",
             @"image": @"image",
             @"categoryDescription": @"description",
             };
}

+ (NSValueTransformer *)imageJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TMEImage class]];
}

@end
