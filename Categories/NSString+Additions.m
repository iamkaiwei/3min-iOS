//
//  NSString+Additions.m
//  Aurora
//
//  Created by Daud Abas on 24/2/12.
//  Copyright (c) 2012 2359 Media Pte Ltd. All rights reserved.
//

#import <time.h>
#import "NSString+Additions.h"
#import <CommonCrypto/CommonDigest.h>
#import "ISO8601DateFormatter.h"

@implementation NSString (Additions)

- (NSUInteger)wordCount {
  NSScanner *scanner = [NSScanner scannerWithString: self];
  NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
  
  NSUInteger count = 0;
  while ([scanner scanUpToCharactersFromSet: whiteSpace  intoString: nil])
    count++;
  
  return count;
}

- (NSArray *)charArray
{
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[self length]];
    for (int i=0; i < [self length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [self characterAtIndex:i]];
        [characters addObject:ichar];
    }
    return characters;
}


- (BOOL)contains:(NSString*)needle {
  NSRange range = [self rangeOfString:needle options: NSCaseInsensitiveSearch];
  return (range.length == needle.length && range.location != NSNotFound);
}

- (BOOL)startsWith:(NSString*)needle {
  NSRange range = [self rangeOfString:needle options: NSCaseInsensitiveSearch];
  return (range.length == needle.length && range.location == 0);
}

- (BOOL)endsWith:(NSString*)needle {
  NSRange range = [self rangeOfString:needle options: NSCaseInsensitiveSearch];
  return (range.length == needle.length && range.location == (self.length-range.length-1));
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString*)URLEncodedString
{
  __autoreleasing NSString *encodedString;
  
  NSString *originalString = (NSString *)self;    
  encodedString = (__bridge_transfer NSString * )
  CFURLCreateStringByAddingPercentEscapes(NULL,
                                          (__bridge CFStringRef)originalString,
                                          (CFStringRef)@"$-_.+!*'(),&+/:;=?@#",
                                          NULL,
                                          kCFStringEncodingUTF8);
  encodedString = [encodedString stringByReplacingOccurrencesOfString:@"%25" withString:@"\%"];   //revert double escape
  return encodedString;
}

- (NSString*)URLEncodeEverything
{
    __autoreleasing NSString *encodedString;
    
    NSString *originalString = (NSString *)self;    
    encodedString = (__bridge_transfer NSString * )
    CFURLCreateStringByAddingPercentEscapes(NULL,
                                            (__bridge CFStringRef)originalString,
                                            NULL,
                                            (CFStringRef)@"$-_.+!*'(),&+/:;=?@#",
                                            kCFStringEncodingUTF8);
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"%25" withString:@"\%"];   //revert double escape
    return encodedString;
}


- (NSString *)sha1 {
  const char *cStr = [self UTF8String];
  unsigned char result[CC_SHA1_DIGEST_LENGTH];
  CC_SHA1(cStr, strlen(cStr), result);
  NSString *s = [NSString  stringWithFormat:
                 @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                 result[0], result[1], result[2], result[3], result[4],
                 result[5], result[6], result[7],
                 result[8], result[9], result[10], result[11], result[12],
                 result[13], result[14], result[15],
                 result[16], result[17], result[18], result[19]
                 ];
  
  return s;
}

- (NSString *)md5 {
  const char *cStr = [self UTF8String];
  unsigned char result[CC_MD5_DIGEST_LENGTH];
  CC_MD5(cStr, strlen(cStr), result);
  NSString *s = [NSString  stringWithFormat:
                 @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                 result[0], result[1], result[2], result[3], result[4],
                 result[5], result[6], result[7],
                 result[8], result[9], result[10], result[11], result[12],
                 result[13], result[14], result[15]
                 ];
  
  return s;
}

+ (NSString*)facebookUserProfileImageUrlWithId:(NSNumber*)fbID
{
    return [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", fbID];
}



#pragma mark - Substring

- (BOOL)matchRegexPattern:(NSString *)pattern
{
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [regExPredicate evaluateWithObject:self];
}

- (NSString *)replaceRegexPattern:(NSString *)pattern withString:(NSString *)newString
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error != nil) {
        DLog(@"%@", error);
        return self;
    }
    
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:newString];
    return modifiedString;
}

- (NSArray *)getAllRangesOfOccurrencesOfString:(NSString *)substring
{
    NSMutableArray * array = [NSMutableArray array];
    NSUInteger count = 0, length = [self length];
    NSRange range = NSMakeRange(0, length);
    
    while (range.location != NSNotFound)
    {
        range = [self rangeOfString:substring options:0 range:range];
        if (range.location != NSNotFound)
        {
            [array addObject:[NSValue valueWithRange:range]];
            
            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            count++;
        }
    }
    
    return array;
}

- (BOOL)safeIsEqualToNumber:(id)stringOrNumber
{
    NSString * anotherString = [NSString stringWithFormat:@"%@", stringOrNumber];
    return [self integerValue] == [anotherString integerValue];
}

@end
