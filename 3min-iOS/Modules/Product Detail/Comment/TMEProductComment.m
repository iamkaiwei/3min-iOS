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
             @"createdAt": @"created_at",
             @"updatedAt": @"updated_at"
             };
}

+ (NSValueTransformer *)userJSONTransformer {
    return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TMEUser class]];
}

+ (NSValueTransformer *)createdAtJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^NSDate *(NSNumber *number) {
        return [NSDate dateWithTimeIntervalSince1970:number.doubleValue];
    }];
}

+ (NSValueTransformer *)updatedAtJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^NSDate *(NSNumber *number) {
        return [NSDate dateWithTimeIntervalSince1970:number.doubleValue];
    }];
}

@end
