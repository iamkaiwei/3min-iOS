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
    image.url = data[@"url"];
    
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
