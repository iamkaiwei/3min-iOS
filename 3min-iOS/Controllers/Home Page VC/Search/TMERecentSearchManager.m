//
//  TMERecentSearchManager.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/29/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMERecentSearchManager.h"

static NSString * const kRecentSearchTextsKey = @"kRecentSearchTextsKey";

@interface TMERecentSearchManager ()



@end

@implementation TMERecentSearchManager

OMNIA_SINGLETON_M(sharedManager)

- (void)save
{
    [[NSUserDefaults standardUserDefaults] setObject:self.recentSearchTexts forKey:kRecentSearchTextsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)load
{
    self.recentSearchTexts = [[NSUserDefaults standardUserDefaults] objectForKey:kRecentSearchTextsKey];
    if (!self.recentSearchTexts) {
        self.recentSearchTexts = [NSMutableArray array];
    }
}

@end
