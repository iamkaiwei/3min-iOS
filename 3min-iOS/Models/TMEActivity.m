//
//  TMEActivity.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/5/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEActivity.h"
#import "TMEUser.h"

@implementation TMEActivity

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"activityId" : @"id",
             };
}

+ (NSValueTransformer *)userJSONTransformer
{
    return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TMEUser class]];
}

@end
