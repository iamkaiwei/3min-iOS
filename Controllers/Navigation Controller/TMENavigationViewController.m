//
//  TMENavigationViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 27/9/13.
//
//

#import "TMENavigationViewController.h"

@interface TMENavigationViewController ()

@end

@implementation TMENavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            UITextAttributeTextColor: [UIColor colorWithHexString:@"ff6600"],
                                                            UITextAttributeTextShadowColor: [UIColor clearColor],
                                                            UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 0.0f)],
                                                            UITextAttributeFont: [UIFont fontWithName:@"Helvetica" size:20.0f]
                                                            }];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
      self.navigationBar.barTintColor = [UIColor colorWithHexString:@"#e4e2e1"];
    else
      self.navigationBar.tintColor = [UIColor colorWithHexString:@"#e4e2e1"];
  }
  return self;
}

@end
