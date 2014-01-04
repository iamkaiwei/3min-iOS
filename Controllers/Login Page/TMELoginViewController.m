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
    

}

- (IBAction)buttonLoginAction:(id)sender {
  [FacebookManager sharedInstance].delegate = self;
  [[FacebookManager sharedInstance] openSessionForPublishing];
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
