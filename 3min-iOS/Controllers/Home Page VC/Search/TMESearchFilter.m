//
//  TMESearchFilter.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/29/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMESearchFilter.h"

@implementation TMESearchFilter

+ (instancetype)defaultFilter
{
    TMESearchFilter *filter = [[TMESearchFilter alloc] init];

    filter.price = 0;
    filter.criteria = TMESearchFilterCriteriaPopular;

    return filter;
}

@end
