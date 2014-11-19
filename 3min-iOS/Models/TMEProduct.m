//
//  TMEProduct.m
//  ThreeMin
//
//  Created by Triệu Khang on 15/7/14.
//
//

#import "TMEProduct.h"
#import "TMEProductImage.h"

@implementation TMEProduct

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
			   @"productID": @"id",
			   @"productDescription": @"description",
			   @"price": @"price",
			   @"soldOut": @"sold_out",
			   @"liked": @"liked",
               @"likeCountNumber": @"likes_count",
			   @"dislikes": @"dislikes",
			   @"venueID": @"venue_name",
			   @"venueLong": @"venue_long",
			   @"venueLat": @"venue_lat",
			   @"createAt": @"create_time",
			   @"updateAt": @"update_time",
			   @"images": @"images",
			   @"category": @"category",
			   @"user": @"owner",
               @"locationText": NSNull.null,
	};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error
{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self) {
        _likeCount = _likeCountNumber.integerValue;
    }

    return self;
}

+ (NSValueTransformer *)createAtJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *timestamp) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timestamp integerValue]];
        return date;
    } reverseBlock:^(NSDate *date) {
        return @([date timeIntervalSince1970]);
    }];
}

+ (NSValueTransformer *)updateAtJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *timestamp) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timestamp integerValue]];
        return date;
    } reverseBlock:^(NSDate *date) {
        return @([date timeIntervalSince1970]);
    }];
}

+ (NSValueTransformer *)userJSONTransformer {
    return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TMEUser class]];
}

+ (NSValueTransformer *)imagesJSONTransformer {
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[TMEProductImage class]];
}

+ (NSValueTransformer *)soldOutJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)likedJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

@end
