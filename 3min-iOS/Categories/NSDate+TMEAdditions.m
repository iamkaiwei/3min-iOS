//
//  NSDate+TMEAdditions.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/24/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "NSDate+TMEAdditions.h"
#import <FormatterKit/TTTTimeIntervalFormatter.h>

@implementation NSDate (TMEAdditions)

- (NSString *)agoString
{
    TTTTimeIntervalFormatter *timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
    return [timeIntervalFormatter stringForTimeInterval:self.timeIntervalSinceNow];
}

@end
