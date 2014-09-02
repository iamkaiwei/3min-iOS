//
//  UITextField+TMEAdditions.m
//  ThreeMin
//
//  Created by Khoa Pham on 9/2/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "UITextField+TMEAdditions.h"

@implementation UITextField (TMEAdditions)

- (void)tme_addDoneButton
{
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar sizeToFit];

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(doneButtonAction:)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil
                                                                                   action:nil];


    toolbar.items = @[ flexibleSpace, doneButton ];

    self.inputAccessoryView = toolbar;
}

- (void)doneButtonAction:(id)sender
{
    [self resignFirstResponder];
}

@end
