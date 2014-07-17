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
      self.navigationBar.frame = CGRectMake(0, 0, 320, 44);
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
      self.navigationBar.barStyle = UIBarStyleBlackTranslucent;
      self.navigationBar.translucent = YES;
      self.navigationBar.barTintColor = [UIColor orangeMainColor];
      self.navigationBar.tintColor = [UIColor whiteColor];
        [[UINavigationBar appearance] setTitleTextAttributes:
         @{ UITextAttributeTextColor: [UIColor whiteColor],
            UITextAttributeTextShadowColor: [UIColor clearColor],
            UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 0.0f)],
            UITextAttributeFont: [UIFont fontWithName:@"HelveticaNeue-Thin" size:25.0f]
            }];
        return self;
    }
      [[UINavigationBar appearance] setTitleTextAttributes:
       @{ UITextAttributeTextColor: [UIColor whiteColor],
          UITextAttributeTextShadowColor: [UIColor clearColor],
          UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 0.0f)],
          UITextAttributeFont: [UIFont fontWithName:@"HelveticaNeue-Light" size:22.0f]
          }];
  }

  return self;
}

@end
