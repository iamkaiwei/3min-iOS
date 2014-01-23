//
//  UIScrollView+Additions.m
//  workflowww
//
//  Created by Torin on 18/5/13.
//  Copyright (c) 2013 workflowww. All rights reserved.
//

#import "UIScrollView+Additions.h"

@implementation UIScrollView (Additions)

/*
 * Auto adjust content size for UIScrollView according to its subviews
 */
- (void)autoAdjustScrollViewContentSize
{
    [self autoAdjustScrollViewContentSizeBottomInset:0];
}

- (void)autoAdjustScrollViewContentSizeBottomInset:(CGFloat)bottomInset
{
    CGFloat maxY = 0;
    for (UIView *subview in self.subviews)
        if (subview.hidden == NO && subview.alpha > 0)
            if (maxY < CGRectGetMaxY(subview.frame))
                maxY = CGRectGetMaxY(subview.frame);
    
    //Extra space at bottom
    maxY += bottomInset;
  
//    if (maxY <= self.height)
//        maxY = self.height;
  
    self.contentSize = CGSizeMake(CGRectGetWidth(self.bounds), maxY + 10);
}

- (void)scrollSubviewToCenter:(UIView*)subview animated:(BOOL)animated
{
    //Cater for subview not directly as a child as well
    CGRect subviewBounds = subview.bounds;
    CGRect subviewFrame = [subview convertRect:subviewBounds toView:self];
    
    CGPoint offset = self.contentOffset;
    CGFloat height = CGRectGetHeight(self.bounds) - self.contentInset.top - self.contentInset.bottom;
    height = ABS(height);
    
    offset.y = CGRectGetMidY(subviewFrame) - height/2;

#warning THIS PART NEED TO BE IMPROVED
    if (offset.y + height > self.contentSize.height)
        offset.y = self.contentSize.height - height;
    if (offset.y < 0)
        offset.y = 0;
  
  [UIView animateWithDuration:.318 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
   [self setContentOffset:offset animated:NO];
  } completion:nil];
  
}

@end
