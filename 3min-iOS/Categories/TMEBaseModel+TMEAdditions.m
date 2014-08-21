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
    NSAssert([JSONResponse isKindOfClass:NSArray.class], @"JSONResponse must be an array");

    NSError *error = nil;
    return [MTLJSONAdapter modelsOfClass:[self class] fromJSONArray:JSONResponse error:&error];
}

+ (instancetype)tme_modelFromJSONResponse:(id)JSONResponse
{
    NSAssert([JSONResponse isKindOfClass:NSDictionary.class], @"JSONResponse must be a dictionary");

    NSError *error = nil;
    return [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:JSONResponse error:&error];
}

@end
