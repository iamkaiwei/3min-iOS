//
//  KZPropertyMapper+DateBoxing.m
//  ThreeMin
//
//  Created by Triệu Khang on 5/5/14.
//
//

#import "KZPropertyMapper+DateBoxing.h"
#import "KZPropertyMapper.h"
#import <objc/message.h>
#import "KZPropertyMapperCommon.h"
#import "KZPropertyDescriptor.h"

@implementation KZPropertyMapper (DateBoxing)

+ (NSDate *)boxValueAsDateSince1970:(id)value __used
{
    if (value == nil) {
        return nil;
    }
    AssertTrueOrReturnNil([value isKindOfClass:NSNumber.class]);
    return [NSDate dateWithTimeIntervalSince1970:[value floatValue]];
}

@end
