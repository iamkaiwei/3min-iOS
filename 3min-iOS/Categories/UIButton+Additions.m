//
//  UIButton+Additions.m
//  EagleChild
//
//  Created by Torin on 16/8/13.
//
//

#import "UIButton+Additions.h"
#import "UIView+Additions.h"

@implementation UIButton (Additions)

- (void)autofitTextKeepRight:(BOOL)keepRight
{
    NSString * text = self.titleLabel.text;
    CGSize expectedSize = [text sizeWithFont:self.titleLabel.font];
    CGFloat width = MAX(CGRectGetWidth(self.bounds), expectedSize.width + 20*2);    //add padding to the sides
    
    [self resizeWidthTo:width keepRight:keepRight];
}

- (void)setSelectedWithEffect:(BOOL)selected animated:(BOOL)animated
{
    [self setSelected:selected];
    
    if (selected == NO)
    {
        if (animated)     [self animateShadowToOpacity:0 duration:0.35];
        else              self.layer.shadowOpacity = 0;
        return;
    }
    
    self.layer.shadowColor = [UIColor colorWithRed:1 green:0.7 blue:0.35 alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowRadius = 6;
    self.layer.masksToBounds = NO;
    self.clipsToBounds = NO;
    
    if (animated)     [self animateShadowToOpacity:1 duration:0.35];
    else              self.layer.shadowOpacity = 1;
}

- (void)adjustNavigationBarButtonDependSystem
{
    CGRect frame = self.frame;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        frame.origin.x += 10;
        frame.size.width -= 10;
        self.frame = frame;
        return;
    }
    
    return;
}

@end
