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
	    if (![dim isKindOfClass:NSArray.class]) return nil;
	    if (dim.count != 2) return nil;
	    CGSize dimensions = CGSizeMake([dim[0] floatValue], [dim[1] floatValue]);
	    return [NSValue valueWithCGSize:dimensions];
	}];

	[NSValueTransformer setValueTransformer:dimValueTransformer forName:DimensionsValueTransformerName];
}

@end
