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
			   @"likes": @"likes",
			   @"liked": @"liked",
			   @"dislikes": @"dislikes",
			   @"venueID": @"venue_name",
			   @"venueLong": @"venue_long",
			   @"venueLat": @"venue_lat",
			   @"createAt": @"create_time",
			   @"updateAt": @"update_time",
			   @"images": @"images",
			   @"category": @"category",
			   @"user": @"owner"
	};
}

+ (NSDateFormatter *)dateTimeFormatter {
	static NSDateFormatter *dateTimeFormatter = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    dateTimeFormatter = [[NSDateFormatter alloc] init];
	    [dateTimeFormatter setDateFormat:@"dd-MM-yyyy"];
	});

    return dateTimeFormatter;
}

+ (NSValueTransformer *)createAtJSONTranformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *timestamp) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timestamp integerValue]];
        return date;
    } reverseBlock:^(NSDate *date) {
        return @([date timeIntervalSince1970]);
    }];
}

+ (NSValueTransformer *)updateAtJSONTranformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *timestamp) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timestamp integerValue]];
        return date;
    } reverseBlock:^(NSDate *date) {
        return @([date timeIntervalSince1970]);
    }];
}

+ (NSValueTransformer *)ownerJSONTranformer {
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[TMEUser class]];
}

+ (NSValueTransformer *)imagesJSONTranformer {
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[TMEProductImage class]];
}

+ (NSValueTransformer *)soldOutJSONTranformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)likedJSONTranformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

@end
