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
			   @"description": @"description",
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

+ (NSValueTransformer *)thumbURLJSONTranformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)squareURLJSONTranformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)mediumURLJSONTranformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)originURLJSONTranformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
