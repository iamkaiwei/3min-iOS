//
//  NSValueTransformer+Addition.m
//  ThreeMin
//
//  Created by Triệu Khang on 20/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

NSString *const DimensionsValueTransformerName = @"DimensionsValueTransformerName";

#import "NSValueTransformer+Addition.h"

@implementation NSValueTransformer (Addition)

+ (void)load {
    MTLValueTransformer *dimValueTransformer = [MTLValueTransformer
                                                reversibleTransformerWithBlock: ^id (NSArray *dim) {
                                                    CGSize defaultSize = CGSizeMake(150, 200);
                                                    if (![dim isKindOfClass:NSArray.class]) return [NSValue valueWithCGSize:defaultSize];
                                                    if (dim.count != 2) return [NSValue valueWithCGSize:defaultSize];
                                                    CGSize dimensions = CGSizeMake([dim[0] floatValue], [dim[1] floatValue]);
                                                    return [NSValue valueWithCGSize:dimensions];
                                                }];
    
    [NSValueTransformer setValueTransformer:dimValueTransformer forName:DimensionsValueTransformerName];
}

@end
