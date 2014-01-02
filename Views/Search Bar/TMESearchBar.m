//
//  TMESearchBar.m
//  PhotoButton
//
//  Created by Toan Slan on 1/2/14.
//
//

#import "TMESearchBar.h"

@implementation TMESearchBar

- (void)layoutSubviews
{
  UIColor *grayLightColor = [UIColor colorWithHexString:@"bbbbbb"];
  
  UITextField *searchField;
  NSUInteger numViews = [self.subviews count];
  for(int i = 0; i < numViews; i++) {
    if([[self.subviews objectAtIndex:i] isKindOfClass:[UITextField class]]) {
      searchField = [self.subviews objectAtIndex:i];
    }
  }
  if(!(searchField == nil)) {
    [searchField setBackground:nil];
    [searchField setBackgroundColor:[UIColor whiteColor]];
    searchField.layer.borderColor = [grayLightColor CGColor];
    searchField.layer.borderWidth = 0.8f;
  }
  
  [self setImage:[UIImage imageNamed:@"search_icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
  [self setImage:[UIImage imageNamed:@"clear_button"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
  [self setImage:[UIImage imageNamed:@"clear_button_pressed"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateHighlighted];
  
  [self setShowsCancelButton:NO animated:NO];
  
  [self clearSearchBarBackground];
  [super layoutSubviews];
}

- (void)clearSearchBarBackground{
  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
    for (UIView *subview in [[self.subviews objectAtIndex:0]subviews]) {
      if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
        [subview removeFromSuperview];
        return;
      }
    }
  }
  
  for (UIView *subview in self.subviews) {
    if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
      [subview removeFromSuperview];
    }
  }
  
}

@end
