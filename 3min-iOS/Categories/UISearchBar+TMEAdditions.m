//
//  UISearchBar+TMEAdditions.m
//  ThreeMin
//
//  Created by Khoa Pham on 9/2/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "UISearchBar+TMEAdditions.h"

@implementation UISearchBar (TMEAdditions)

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
    [self tme_resignFirstResponderWithCancelButtonEnabled];
}

- (void)tme_resignFirstResponderWithCancelButtonEnabled
{
    [self resignFirstResponder];

    UIButton *cancelButton = [self tme_cancelButton];
    cancelButton.enabled = YES;
}

- (UIButton *)tme_cancelButton
{
    // FIXME: This hierarchy holds true for iOS 7 only
    for (UIView *view in self.subviews)
    {
        for (id subview in view.subviews)
        {
            if ([subview isKindOfClass:[UIButton class]])
            {
                return subview;
            }
        }
    }

    return nil;
}

@end
