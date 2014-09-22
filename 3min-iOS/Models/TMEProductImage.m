//
//  TMEProductImage.m
//  ThreeMin
//
//  Created by Triệu Khang on 15/7/14.
//
//

#import "TMEProductImage.h"

@implementation TMEProductImage

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
			   @"ID": @"id",
			   @"name": @"name",
			   @"imageDescription": @"description",
			   @"dim": @"dimensions",
			   @"thumbURL": @"thumb",
			   @"squareURL": @"square",
			   @"mediumURL": @"medium",
			   @"originURL": @"origin"
	};
}

+ (NSValueTransformer *)dimJSONTransformer {
	return [NSValueTransformer valueTransformerForName:DimensionsValueTransformerName];
}

+ (NSValueTransformer *)thumbURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)squareURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)mediumURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)originURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
