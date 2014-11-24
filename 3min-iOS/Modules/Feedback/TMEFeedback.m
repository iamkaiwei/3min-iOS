//
//  TMEFeedback.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/22/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEFeedback.h"

@implementation TMEFeedback

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"feedbackID": @"id",
             @"content": @"content",
             @"user": @"user",
             @"updatedAt": @"update_time",
             @"feedbackStatus": @"status",
             };
}

+ (NSValueTransformer *)userJSONTransformer {
    return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TMEUser class]];
}

+ (NSValueTransformer *)updatedAtJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^NSDate *(NSNumber *number) {
        return [NSDate dateWithTimeIntervalSince1970:number.doubleValue];
    }];
}

+ (NSValueTransformer *)feedbackStatusJSONTransformer {
    return [MTLValueTransformer mtl_valueMappingTransformerWithDictionary:@{@"negative": @(TMEFeedbackStatusNegative),
                                                                            @"positive": @(TMEFeedbackStatusPositive),
                                                                            }
                                                             defaultValue:@(TMEFeedbackStatusUnknown)
                                                      reverseDefaultValue:nil];
}

@end
