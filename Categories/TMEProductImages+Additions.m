//
//  TMEProductImages+Additions.m
//  PhotoButton
//
//  Created by Triệu Khang on 25/9/13.
//
//

#import "TMEProductImages+Additions.h"

@implementation TMEProductImages (Additions)

+ (TMEProductImages *)productImageFromDictionary:(NSDictionary *)data
{
    TMEProductImages *image = [TMEProductImages MR_createEntity];
    image.imageID = data[@"id"];
    image.small = data[@"small"];
    image.thumb = data[@"thumb"];
    image.medium = data[@"medium"];
    image.origin = data[@"origin"];
    image.update_at = data[@"update_at"];
    return image;
}

+ (NSArray *)productImagesFromArray:(NSArray *)arrayData
{
    NSMutableArray *arrImage = [@[] mutableCopy];
    for (NSDictionary *data in arrayData) {
        id image = [TMEProductImages productImageFromDictionary:data];
        [arrImage addObject:image];
    }
    
    return arrImage;
}

+ (NSSet *)productImagesSetFromArray:(NSArray *)arrayData
{
    NSArray *arrImages = [TMEProductImages productImagesFromArray:arrayData];
    NSSet *setImages = [NSSet setWithArray:arrImages];
    
    return setImages;
}

@end
