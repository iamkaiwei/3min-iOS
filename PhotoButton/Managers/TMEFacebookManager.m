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
      [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"No connection!", nil)];
      [FBSession.activeSession close];
      return;
    }
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Login...", nil) maskType:SVProgressHUDMaskTypeGradient];
    [[TMEUserManager sharedInstance] loginBySendingFacebookWithSuccessBlock:^(TMEUser *tmeUser) {
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Login successfully", nil)];
        [[TMEUserManager sharedInstance] setLoggedUser:tmeUser andFacebookUser:user];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:TMEShowHomeViewControllerNotification
                                                            object:nil];
        
    } andFailureBlock:^(NSInteger statusCode, id obj) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Login failed", nil)];
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
