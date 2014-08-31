//
//  UIBarButtonItem+Additions.h
//  ThreeMin
//
//  Created by Triệu Khang on 26/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Additions)

/**
 *  Return button of UIBarButtonItem's custom view
 *
 *  @return nil if UIBarButtonItem's custom view is not UIButton
 */
- (UIButton *)getButton;

@end
