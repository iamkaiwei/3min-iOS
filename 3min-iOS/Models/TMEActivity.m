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

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
			   @"activityId" : @"id",
			   @"subjectType" : @"subject_type",
			   @"displayURL" : @"display_image_url",
			   @"subjectId" : @"subject_id",
			   @"updateTime" : @"update_time",
	};
}

+ (NSValueTransformer *)userJSONTransformer {
	return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TMEUser class]];
}

+ (NSValueTransformer *)displayURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
