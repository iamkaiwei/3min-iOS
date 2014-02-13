//
//  TMEFacebookManager.m
//  PhotoButton
//
//  Created by Triệu Khang on 26/10/13.
//
//

#import "AppDelegate.h"
#import "TMEFacebookManager.h"

@implementation TMEFacebookManager

SINGLETON_MACRO

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user
{
    if (![TMEReachabilityManager isReachable]) {
      [SVProgressHUD showErrorWithStatus:@"No connection!"];
      [FBSession.activeSession close];
      return;
    }
    [SVProgressHUD showWithStatus:@"Login..." maskType:SVProgressHUDMaskTypeGradient];
    [[TMEUserManager sharedInstance] loginBySendingFacebookWithSuccessBlock:^(TMEUser *tmeUser) {
        [SVProgressHUD showSuccessWithStatus:@"Login successfully"];
        [[TMEUserManager sharedInstance] setLoggedUser:tmeUser andFacebookUser:user];
        
        [SVProgressHUD dismiss];
        [[AppDelegate sharedDelegate] showHomeViewController];
        
    } andFailureBlock:^(NSInteger statusCode, id obj) {
        [SVProgressHUD showErrorWithStatus:@"Login failure"];
    }];
}

- (void)openSession
{
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession];
}

- (void)loginFailed
{
    // User switched back to the app without authorizing. Stay here, but
    // stop the spinner.
}

- (void)showLoginView
{
    [[AppDelegate sharedDelegate] showLoginView];
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    
}

@end
