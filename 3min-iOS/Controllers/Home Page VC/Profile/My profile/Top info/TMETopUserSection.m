//
//  TMETopUserSection.m
//  ThreeMin
//
//  Created by Triệu Khang on 30/10/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMETopUserSection.h"

@implementation TMETopUserSection

- (NSUInteger)count {
    return 1;
}

- (id)objectAtIndex:(NSUInteger)index {
    TMEUser *user = [[TMEUserManager sharedManager] loggedUser];
    return user;
}

@end
