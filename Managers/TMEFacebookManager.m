//
//  TMEFacebookManager.m
//  PhotoButton
//
//  Created by Triệu Khang on 26/10/13.
//
//

#import "AppDelegate.h"
#import "TMEFacebookManager.h"

@interface TMEFacebookManager()

@property (assign, nonatomic) BOOL postingInProgress;

@end

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

- (void)postPhotoWithText:(NSString *) message
           imageURL:(NSString *) imageURL
{
  
  NSMutableDictionary* params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                 imageURL, @"url",
                                 message, @"message",
                                 nil];
  
  if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound)
  {
    // No permissions found in session, ask for it
    [FBSession.activeSession requestNewPublishPermissions: [NSArray arrayWithObject:@"publish_actions"]
                                          defaultAudience: FBSessionDefaultAudienceFriends
                                        completionHandler: ^(FBSession *session, NSError *error)
     {
       if (!error)
       {
         // If permissions granted and not already posting then publish the story
         if (!self.postingInProgress)
         {
           [self postToWall: params];
         }
       }
     }];
    return;
  }
    // If permissions present and not already posting then publish the story
    if (!self.postingInProgress)
    {
      [self postToWall: params];
    }
}

- (void)postToWall:(NSMutableDictionary*) params
{
  self.postingInProgress = YES; //for not allowing multiple hits
  
  [FBRequestConnection startWithGraphPath:@"me/photos"
                               parameters:params
                               HTTPMethod:@"POST"
                        completionHandler:^(FBRequestConnection *connection,
                                            id result,
                                            NSError *error)
   {
     if (error)
     {
       //showing an alert for failure
       UIAlertView *alertView = [[UIAlertView alloc]
                                 initWithTitle:@"Post Failed"
                                 message:error.localizedDescription
                                 delegate:nil
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
       [alertView show];
     }
     self.postingInProgress = NO;
   }];
}

@end
