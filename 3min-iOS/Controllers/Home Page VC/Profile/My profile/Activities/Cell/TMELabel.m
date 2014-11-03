//
//  TMELabel.m
//  ThreeMin
//
//  Created by Triệu Khang on 25/10/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMELabel.h"

@implementation TMELabel

- (CGSize)intrinsicContentSize {
    if ([self.text isEqual:@""]) {
        return CGSizeMake(UIViewNoIntrinsicMetric, 0);
    }

    return [super intrinsicContentSize];
}

@end
