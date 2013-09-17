//
//  NSString+Validation.m
//  Aurora
//
//  Created by Torin on 23/12/12.
//  Copyright (c) 2012 MyCompany. All rights reserved.
//

#import "NSString+Validation.h"
#import "NSString+Additions.h"

@implementation NSString (Validation)

- (BOOL)isEmail
{
    static NSString *regularExpressionString = @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    return [self matchRegexPattern:regularExpressionString];
}

- (BOOL)isNumber
{
    NSCharacterSet* nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange r = [self rangeOfCharacterFromSet: nonNumbers];
    return r.location == NSNotFound;
}

- (BOOL)isValidName
{
    if (self.length < 3)
        return NO;
    
    static NSString *regularExpressionString = @"^[a-zA-Z0-9-_' ]+$";    //alphanumberic, dash, underscore, space, apos
    return [self matchRegexPattern:regularExpressionString];
}

- (BOOL)isPhoneNumber
{
    if (self.length < 8)
        return NO;
    
    static NSString *regularExpressionString = @"^[0-9-+() ]+$";
    return [self matchRegexPattern:regularExpressionString];
}

- (BOOL)isValidNRIC
{
    if (self.length != 9)
        return NO;
    
    unichar prefix = [[self uppercaseString] characterAtIndex:0];
    NSString *mid = [[self uppercaseString] substringWithRange:NSMakeRange(1, 7)];
    unichar suffix = [[self uppercaseString] characterAtIndex:8];
    
    if ((prefix >= '0' && prefix <= '9') || (suffix >= '0' && suffix <= '9'))
        return NO;
    
    NSUInteger total = 0;
    NSUInteger value = 0;
    for (int charIndex = 0; charIndex < mid.length; charIndex++) {
        unichar c = [mid characterAtIndex:charIndex];
        
        if (c < '0' || c > '9')
            return NO;
        
        value = c - 48;
        
        if (charIndex == 0) {
            total += 2 * value;
        } else {
            total += (mid.length - charIndex + 1) * value;
        }
    }
    
    if (prefix == 'T' || prefix == 'G') {
        total += 4;
    }
    
    NSUInteger remainder = total % 11;
    
    NSDictionary *sgSuffix = @{@(0) : @"J",
                               @(1) : @"Z",
                               @(2) : @"I",
                               @(3) : @"H",
                               @(4) : @"G",
                               @(5) : @"F",
                               @(6) : @"E",
                               @(7) : @"D",
                               @(8) : @"C",
                               @(9) : @"B",
                               @(10) : @"A" };
    
    NSDictionary *prSuffix = @{@(0) : @"X",
                               @(1) : @"W",
                               @(2) : @"U",
                               @(3) : @"T",
                               @(4) : @"R",
                               @(5) : @"Q",
                               @(6) : @"P",
                               @(7) : @"N",
                               @(8) : @"M",
                               @(9) : @"L",
                               @(10) : @"K" };
    
    
    NSString *suffixString = nil;
    unichar suffixFromTable = 0;
    if (prefix == 'S' || prefix == 'T') {
        suffixString = [sgSuffix objectForKey:@(remainder)];
    } else if (prefix == 'F' || prefix == 'G') {
        suffixString = [prSuffix objectForKey:@(remainder)];
    }
    
    if (suffixString) {
        suffixFromTable = [[suffixString uppercaseString] characterAtIndex:0];
    }
    
    if (!suffixString || suffix != suffixFromTable) {
        return NO;
    }
    
    return YES;
}



#pragma mark -

- (NSDate*)dateFromISO8601String
{
    static ISO8601DateFormatter *dateFormatter = nil;
    if (dateFormatter == nil)
        dateFormatter = [[ISO8601DateFormatter alloc] init];
    
    NSDate *theDate = [dateFormatter dateFromString:self];
    return theDate;
}

- (BOOL)isISO8601String
{
    return [self dateFromISO8601String] != nil;
}

- (BOOL)isISO8601DateOnlyString
{
    NSString *regularExpressionString = @"^(\\d{4})\\D?(0[1-9]|1[0-2])\\D?([12]\\d|0[1-9]|3[01])$";
    return [self matchRegexPattern:regularExpressionString];
}

- (BOOL)isISO8601TimeOnlyString
{
    NSString *regularExpressionString = @"^([01]\\d|2[0-3])\\D?([0-5]\\d)\\D?([0-5]\\d)?\\D?(\\d{3})?$";
    return [self matchRegexPattern:regularExpressionString];
}

- (BOOL)isISO8601DateTimeOnlyString
{
    NSString *regularExpressionString = @"^(\\d{4})\\D?(0[1-9]|1[0-2])\\D?([12]\\d|0[1-9]|3[01])(\\D?([01]\\d|2[0-3])\\D?([0-5]\\d)\\D?([0-5]\\d)?\\D?(\\d{3})?)?$";
    return [self matchRegexPattern:regularExpressionString];
}

- (BOOL)isISO8601DateTimeOffsetString
{
    NSString *regularExpressionString = @"^(\\d{4})\\D?(0[1-9]|1[0-2])\\D?([12]\\d|0[1-9]|3[01])(\\D?([01]\\d|2[0-3])\\D?([0-5]\\d)\\D?([0-5]\\d)?\\D?(\\d{3})?([zZ]|([\\+-])([01]\\d|2[0-3])\\D?([0-5]\\d)?)?)?$";
    return [self matchRegexPattern:regularExpressionString];
}

@end
