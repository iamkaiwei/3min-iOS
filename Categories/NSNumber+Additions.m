//
//  NSNumber+Additions.m
//  FashTag
//
//  Created by Torin on 8/4/13.
//
//

#import "NSNumber+Additions.h"

@implementation NSNumber (Additions)

- (NSUInteger)length
{
  DLog(@"WARNING: attempt to perform selector 'length' on a NSNumber object");
  return 0;
}

- (BOOL)safeIsEqualToNumber:(id)stringOrNumber
{
    NSString * anotherString = [NSString stringWithFormat:@"%@", stringOrNumber];
    return [self integerValue] == [anotherString integerValue];
}

@end
