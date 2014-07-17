//
//  KZPropertyMapper+DateBoxing.h
//  ThreeMin
//
//  Created by Triệu Khang on 5/5/14.
//
//

#import "KZPropertyMapper.h"

@interface KZPropertyMapper (DateBoxing)

+ (NSDate *)boxValueAsDateSince1970:(id)value __used;

@end
