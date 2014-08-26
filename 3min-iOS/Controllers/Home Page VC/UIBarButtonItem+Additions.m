//
//  UIBarButtonItem+Additions.m
//  ThreeMin
//
//  Created by Triệu Khang on 26/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "UIBarButtonItem+Additions.h"

@implementation UIBarButtonItem (Additions)

- (UIButton *)getButton {
    if ([self.customView isKindOfClass:[UIButton class]]) {
        return (UIButton *) self.customView;
    }

    return nil;
}

@end
