//
//  TMEFacebookManager.m
//  PhotoButton
//
//  Created by Triệu Khang on 26/10/13.
//
//

#import "AppDelegate.h"
#import "TMEFacebookManager.h"
#import <Facebook-iOS-SDK/FacebookSDK/FacebookSDK.h>

@interface TMEFacebookManager ()

@property (nonatomic, copy) TMEFacebookManagerSuccessBlock succcessBlock;
@property (nonatomic, copy) TMEFailureBlock failureBlock;

@end

@implementation TMEFacebookManager

OMNIA_SINGLETON_M(sharedManager)

#pragma mark - Refactor
- (void)setup
{
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {

        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:self.facebookPermissions
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          // Handler for session state changes
                                          // This method will be called EACH time the session state changes,
                                          // also for intermediate states and NOT just when the session open
                                          [self sessionStateChanged:session state:state error:error];
                                      }];
    }

    [self registerNotifications];
}

- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
{
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}

- (void)handleDidBecomeActive
{
    //[FBSession.activeSession handleDidBecomeActive];
    //[FBAppEvents activateApp];
    [FBAppCall handleDidBecomeActive];
}

// This method will handle ALL the session state changes in the app
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState)state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        // Show the user the logged-in UI
        [self userLoggedIn];
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
        // Show the user the logged-out UI
        [self userLoggedOut];
    }

    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
            [self showMessage:alertText withTitle:alertTitle];
        } else {

            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");

                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                [self showMessage:alertText withTitle:alertTitle];

                // Here we will handle all other errors with a generic error message.
                // We recommend you check our Handling Errors guide for more information
                // https://developers.facebook.com/docs/ios/errors/
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];

                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                [self showMessage:alertText withTitle:alertTitle];
            }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
}



- (void)signInWithSuccess:(TMEFacebookManagerSuccessBlock)success
                  failure:(TMEFailureBlock)failure
{
    // Open a session showing the user the login UI
    // You must ALWAYS ask for public_profile permissions when opening a session
    [FBSession openActiveSessionWithReadPermissions:self.facebookPermissions
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, FBSessionState state, NSError *error)
    {
         if (state != FBSessionStateOpen) {
             return;
         }

         // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
         [self sessionStateChanged:session state:state error:error];

        if (error) {
            if (failure) {
                failure(error);
            }
        } else {
            if (success) {
                success(session.accessTokenData.accessToken);
            }
        }
     }];
}

#pragma mark - Helper
- (NSArray *)facebookPermissions
{
    return @[ @"public_profile", @"email", @"user_birthday", @"user_status", @"friends_status" ];
}

- (void)userLoggedOut {

}

- (void)userLoggedIn {

}

- (void)showMessage:(NSString *)message withTitle:(NSString *)title {

}

#pragma mark - Notification
- (void)registerNotifications
{
    [self tme_registerNotifications:@{TMEUserDidLogoutNotification:
                                          NSStringFromSelector(@selector(handleUserDidLogoutNotification:)),
                                      }];
}

- (void)handleUserDidLogoutNotification:(NSNotification *)note
{
    // TODO:
}

@end
