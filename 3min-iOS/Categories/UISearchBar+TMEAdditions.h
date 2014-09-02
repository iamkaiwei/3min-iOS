//
//  UISearchBar+TMEAdditions.h
//  ThreeMin
//
//  Created by Khoa Pham on 9/2/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (TMEAdditions)

- (void)tme_addDoneButton;
- (void)tme_resignFirstResponderWithCancelButtonEnabled;

@end
