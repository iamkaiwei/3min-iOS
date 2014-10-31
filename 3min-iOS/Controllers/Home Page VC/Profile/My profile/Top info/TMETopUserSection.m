//
//  TMETopUserSection.m
//  ThreeMin
//
//  Created by Triệu Khang on 30/10/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMETopUserSection.h"

@interface TMETopUserSection()

@property (strong, nonatomic) TMEUser *user;

@end

@implementation TMETopUserSection

- (void)setUser:(TMEUser *)user {
    _user = user;
}

- (NSUInteger)count {
    return 1;
}

- (id)objectAtIndex:(NSUInteger)index {
    return self.user;
}

@end
