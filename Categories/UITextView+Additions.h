//
//  UITextView+Additions.h
//  EagleChild
//
//  Created by Torin on 5/8/13.
//
//

#import <UIKit/UIKit.h>

@interface UITextView (Additions)

- (void)sizeToFitKeepHeight;
- (void)sizeToFitKeepWidth;
- (CGFloat)expectedHeight;

- (CGRect)getLocalFrameOfText:(NSString *)subString;
- (CGRect)getParentFrameOfText:(NSString *)subString;

- (NSArray *)getAllLocalFramesOfText:(NSString *)subString;
- (NSArray *)getAllParentFramesOfText:(NSString *)subString;

@end
