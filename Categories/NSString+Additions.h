//
//  NSString+Additions.h
//  Aurora
//
//  Created by Daud Abas on 24/2/12.
//  Copyright (c) 2012 2359 Media Pte Ltd. All rights reserved.
//



@interface NSString (Additions)

- (NSUInteger)wordCount;
- (NSArray *)charArray;
+ (NSString *)getLastestUpdateString;


- (BOOL)contains:(NSString*)needle;
- (BOOL)startsWith:(NSString*)needle;
- (BOOL)endsWith:(NSString*)needle;
- (NSString *)trim;

- (NSString*)URLEncodedString;
- (NSString*)URLEncodeEverything;

- (NSString *)sha1;
- (NSString *)md5;

+ (NSString*)facebookUserProfileImageUrlWithId:(NSNumber*)fbID;

- (BOOL)matchRegexPattern:(NSString *)pattern;
- (NSString *)replaceRegexPattern:(NSString *)pattern withString:(NSString *)newString;
- (NSArray *)getAllRangesOfOccurrencesOfString:(NSString *)substring;

- (BOOL)safeIsEqualToNumber:(id)stringOrNumber;

@end
