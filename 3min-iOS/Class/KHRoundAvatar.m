//
//  KHRoundAvatar.m
//  RoundImage
//
//  Created by Triệu Khang on 3/8/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHRoundAvatar.h"

@implementation KHRoundAvatar

- (void)setImage:(UIImage *)image {
    [self applyMask];
    [super setImage:image];
}

- (void)applyMask {
    CALayer *mask = [CALayer layer];
    mask.frame = self.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"bg_avatar"];
    mask.contents = (__bridge id)maskImage.CGImage;
    self.layer.mask = mask;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self applyMask];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self applyMask];
    }

    return self;
}

@end
