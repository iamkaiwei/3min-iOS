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

OMNIA_SINGLETON_M(sharedManager)

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user
{
    if (![TMEReachabilityManager isReachable]) {
      [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"No connection!", nil)];
      [FBSession.activeSession close];
      return;
    }
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Login...", nil) maskType:SVProgressHUDMaskTypeGradient];
    [[TMEUserManager sharedManager] loginBySendingFacebookWithSuccessBlock:^(TMEUser *tmeUser) {
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Login successfully", nil)];
        [[TMEUserManager sharedManager] setLoggedUser:tmeUser andFacebookUser:user];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:TMEShowHomeViewControllerNotification
                                                            object:nil];
        
    } andFailureBlock:^(id obj) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Login failed", nil)];
    }];
}

- (void)openSession
{
    // FIXME: loop call
    //AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    //[appDelegate openSession];
}

- (void)loginFailed
{
    // User switched back to the app without authorizing. Stay here, but
    // stop the spinner.
}

- (void)showLoginView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TMEShowLoginViewControllerNotification
                                                        object:nil];
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    
}

@end
