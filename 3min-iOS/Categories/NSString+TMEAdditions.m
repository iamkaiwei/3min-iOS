//
//  NSString+TMEAdditions.m
//  ThreeMin
//
//  Created by Khoa Pham on 9/22/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "NSString+TMEAdditions.h"

NSString *NSStringf(NSString *format, ...) {
    va_list ap;
    NSString *string;
    va_start(ap, format);
    string = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);

    return string;
}

@implementation NSString (TMEAdditions)

@end
