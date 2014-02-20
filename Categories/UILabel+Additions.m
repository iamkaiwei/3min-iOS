//
//  UILabel+Additions.m
//  FashTag
//
//  Created by Torin on 19/3/13.
//
//

#import "UILabel+Additions.h"

@implementation UILabel (Additions)

- (void)sizeToFitKeepHeight
{
  CGFloat initialHeight = CGRectGetHeight(self.frame);
  [self sizeToFit];
  CGRect frame = self.frame;
  frame.size.height = initialHeight;
  self.frame = frame;
}

- (void)sizeToFitKeepHeightAlignRight{
  CGRect beforeFrame = self.frame;
  [self sizeToFitKeepHeight];
  CGRect afterFrame = self.frame;
  self.frame = CGRectMake(beforeFrame.origin.x + beforeFrame.size.width - afterFrame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)sizeToFitKeepWidth
{
  CGFloat initialWidth = CGRectGetWidth(self.frame);
  [self sizeToFit];
  CGRect frame = self.frame;
  frame.size.width = initialWidth;
  self.frame = frame;
}

- (CGFloat)expectedHeight
{
    if ([self.text length] <= 0)
        return 0;
    
    CGSize expectedLabelSize = [self.text sizeWithFont:self.font
                                     constrainedToSize:CGSizeMake(self.frame.size.width, 9999)
                                         lineBreakMode:NSLineBreakByWordWrapping];
    return expectedLabelSize.height;
}

- (CGFloat)expectedWidth
{
    if ([self.text length] <= 0)
        return 0;
    
    CGSize expectedLabelSize = [self.text sizeWithFont:self.font
                                     constrainedToSize:CGSizeMake(9999, self.frame.size.height)
                                         lineBreakMode:NSLineBreakByWordWrapping];
    return expectedLabelSize.width;
}


@end
