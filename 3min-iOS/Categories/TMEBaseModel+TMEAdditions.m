//
//  TMEBaseModel+TMEAdditions.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/5/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEBaseModel+TMEAdditions.h"

@implementation TMEBaseModel (TMEAdditions)

+ (NSArray *)tme_modelsFromJSONResponse:(id)JSONResponse
{
    NSAssert([JSONResponse isMemberOfClass:NSArray.class], @"JSONResponse must be an array");

    NSError *error = nil;
    return [MTLJSONAdapter modelsOfClass:self fromJSONArray:JSONResponse error:&error];
}

@end
