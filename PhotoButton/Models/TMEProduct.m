//
//  TMEProduct.m
//  ThreeMin
//
//  Created by Triệu Khang on 15/7/14.
//
//

#import "TMEProduct.h"

@implementation TMEProduct <MTLJSONSerializing>

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"productID": @"id",
             @"productDescription": @"description",
             @"price": @"price",
             @"soldOut": @"sold_out",
             @"likes": @"likes",
             @"dislikes": @"dislikes",
             @"venueID": @"venue_name",
             @"venueLong": @"venue_long",
             @"venueLat": @"venue_lat",
             @"createAt": @"create_at",
             @"updateAt": @"update_at",
             @"images": @"images",
             @"category": @"category",
             @"user": @"owner"
             };
}

@end
