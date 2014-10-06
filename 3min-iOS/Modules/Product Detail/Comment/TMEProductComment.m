//
//  TMEProductComment.m
//  ThreeMin
//
//  Created by Khoa Pham on 10/6/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductComment.h"

@implementation TMEProductComment

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"commentID": @"id",
             @"content": @"content",
             @"user": @"user",
             };
}

+ (NSValueTransformer *)userJSONTransformer {
    return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TMEUser class]];
}

@end
