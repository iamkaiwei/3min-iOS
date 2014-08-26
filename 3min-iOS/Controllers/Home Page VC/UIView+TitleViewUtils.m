//
//  UIView+_Addition.m
//  ThreeMin
//
//  Created by Triệu Khang on 26/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "UIView+TitleViewUtils.h"

@implementation UIView (TitleViewUtils)

- (UIButton *)getButton {

    __block UIButton *button = nil;

    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            button = (UIButton *) obj;
        }
    }];

    return button;
}

@end
