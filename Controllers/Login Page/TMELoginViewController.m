//
//  TMELoginViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 21/9/13.
//
//

#import "TMELoginViewController.h"
#import "AppDelegate.h"

@interface TMELoginViewController ()
<FacebookManagerDelegate
>

@end

@implementation TMELoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view enableOrangeStatusBar];

}

- (IBAction)buttonLoginAction:(id)sender {
  if (![TMEReachabilityManager isReachable]) {
    [SVProgressHUD showErrorWithStatus:@"No connection!"];
    return;
  }
  [FacebookManager sharedInstance].delegate = self;
  [[FacebookManager sharedInstance] openSession];
}

- (void)facebookLoginSucceeded:(FacebookManager *)facebookManager{
  [[FBRequest requestForMe] startWithCompletionHandler:
   ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
     if (!error) {
         [[AppDelegate sharedDelegate] showHomeViewController];
     }
   }];
}

@end
