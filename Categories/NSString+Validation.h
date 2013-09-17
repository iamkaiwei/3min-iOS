//
//  NSString+Validation.h
//  Aurora
//
//  Created by Torin on 23/12/12.
//  Copyright (c) 2012 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validation)

- (BOOL)isEmail;
- (BOOL)isNumber;
- (BOOL)isValidName;
- (BOOL)isPhoneNumber;
- (BOOL)isValidNRIC;

//Date & time
- (NSDate*)dateFromISO8601String;
- (BOOL)isISO8601String;
- (BOOL)isISO8601DateOnlyString;
- (BOOL)isISO8601TimeOnlyString;
- (BOOL)isISO8601DateTimeOnlyString;
- (BOOL)isISO8601DateTimeOffsetString;

@end
