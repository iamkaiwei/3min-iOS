//
//  UITextView+Additions.m
//  EagleChild
//
//  Created by Torin on 5/8/13.
//
//

#import "UITextView+Additions.h"

@implementation UITextView (Additions)

- (void)sizeToFitKeepHeight
{
    CGFloat initialHeight = CGRectGetHeight(self.frame);
    [self sizeToFit];
    CGRect frame = self.frame;
    frame.size.height = initialHeight;
    self.frame = frame;
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



#pragma mark -

- (CGRect)getLocalFrameOfText:(NSString *)subString
{
    NSRange range = [self.text rangeOfString:subString];
    
    UITextPosition * start = [self positionFromPosition:self.beginningOfDocument offset:range.location];
    UITextPosition * end = [self positionFromPosition:start offset:range.length];
    
    UITextRange * textRange = [self textRangeFromPosition:start toPosition:end];
    CGRect rect = [self firstRectForRange:textRange];
    
    return rect;
}

- (CGRect)getParentFrameOfText:(NSString *)subString
{
    CGRect localFrame = [self getLocalFrameOfText:subString];
    if (self.superview == nil)
        return localFrame;
    
    CGRect parentFrame = [self convertRect:localFrame toView:self.superview];
    return parentFrame;
}

- (NSArray *)getAllLocalFramesOfText:(NSString *)subString
{
    NSArray * rangesArray = [self.text getAllRangesOfOccurrencesOfString:subString];
    if ([rangesArray count] <= 0)
        return nil;
    
    NSMutableArray * outputArray = [NSMutableArray array];
    
    for (NSValue * value in rangesArray)
    {
        NSRange range = [value rangeValue];
        
        UITextPosition * start = [self positionFromPosition:self.beginningOfDocument offset:range.location];
        UITextPosition * end = [self positionFromPosition:start offset:range.length];
        
        UITextRange * textRange = [self textRangeFromPosition:start toPosition:end];
        CGRect rect = [self firstRectForRange:textRange];
       
        [outputArray addObject:[NSValue valueWithCGRect:rect]];
    }
    
    return outputArray;
}

- (NSArray *)getAllParentFramesOfText:(NSString *)subString
{
    NSArray * rangesArray = [self.text getAllRangesOfOccurrencesOfString:subString];
    if ([rangesArray count] <= 0)
        return nil;
    
    NSMutableArray * outputArray = [NSMutableArray array];
    
    for (NSValue * value in rangesArray)
    {
        NSRange range = [value rangeValue];
        
        UITextPosition * start = [self positionFromPosition:self.beginningOfDocument offset:range.location];
        UITextPosition * end = [self positionFromPosition:start offset:range.length];
        
        UITextRange * textRange = [self textRangeFromPosition:start toPosition:end];
        CGRect rect = [self firstRectForRange:textRange];
        CGRect parentRect = [self convertRect:rect toView:self.superview];
        
        [outputArray addObject:[NSValue valueWithCGRect:parentRect]];
    }
    
    return outputArray;
}

@end
