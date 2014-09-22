//
//  TMEImage.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/5/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEImage.h"

@implementation TMEImage

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"imageId" : @"id",
             @"urlString": @"url",
             @"imageDescription": @"description"
             };
}

@end
