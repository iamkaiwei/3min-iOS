//
//  TMERootAppDelegateService.m
//  ThreeMin
//
//  Created by Khoa Pham on 7/16/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMERootAppDelegateService.h"
#import "AppDelegate.h"
#import "TMETutorialViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface TMERootAppDelegateService ()

@property (strong, nonatomic) IIViewDeckController *deckController;

@end

@implementation TMERootAppDelegateService

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self registerNotifications];
    }

    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.appDelegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    UIWindow *window = self.appDelegate.window;

    [self setupViewDeckController];

    if (![TMEUserManager sharedManager].loggedUser) {
        [self showLoginViewController];
    }

    [window makeKeyAndVisible];
    return YES;
}

- (void)setupViewDeckController
{
    TMELeftMenuViewController* leftController = [[TMELeftMenuViewController alloc] init];

    TMEHomeViewController *rootVC = [[TMEHomeViewController alloc] init];

    IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:rootVC leftViewController:leftController];

    [deckController setNavigationControllerBehavior:IIViewDeckNavigationControllerIntegrated];
    [deckController setCenterhiddenInteractivity:IIViewDeckCenterHiddenNotUserInteractiveWithTapToCloseBouncing];


    self.deckController = deckController;
}


#pragma mark - Login
- (void)showLoginViewController
{
    TMETutorialViewController *loginViewController = [[TMETutorialViewController alloc] init];
    [self switchRootViewController:loginViewController animated:YES completion:nil];
}

#pragma mark - Home
- (void)showHomeViewController
{
    // FIXME: Leave it for now
     [self switchRootViewController:self.deckController animated:YES completion:nil];
    return;

    if (![[TMEUserManager sharedManager] loggedUser] && [TMEReachabilityManager isReachable]) {
        [SVProgressHUD showWithStatus:NSLocalizedString(@"Login...", nil) maskType:SVProgressHUDMaskTypeGradient];

        // FIXME: fix this stuff
        /*
        [[TMEUserManager sharedManager] loginBySendingFacebookWithSuccessBlock:^(TMEUser *tmeUser) {
            [[TMEUserManager sharedManager] setLoggedUser:tmeUser andFacebookUser:nil];
            [self updateUAAlias];

            [self switchRootViewController:self.deckController animated:YES completion:nil];
            UITabBarController *tabBarController = (UITabBarController *)self.deckController.centerController;
            tabBarController.selectedIndex = 0;
        } andFailureBlock:^(id obj) {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Login failed", nil)];
        }];
         */

        return;
    }

    if (![TMEReachabilityManager isReachable]) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"No connection!", nil)];

        return;
    }

    [self updateUAAlias];
    [self switchRootViewController:self.deckController animated:YES completion:nil];
}

#pragma mark - Helper
- (AppDelegate *)appDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)switchRootViewController:(UIViewController *)viewController
                        animated:(BOOL)animated
                      completion:(void (^)())completion
{
    UIWindow *window = self.appDelegate.window;

    if (animated) {
        [UIView transitionWithView:window
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^
         {
             BOOL oldState = [UIView areAnimationsEnabled];
             [UIView setAnimationsEnabled:NO];
             window.rootViewController = viewController;
             [UIView setAnimationsEnabled:oldState];
         } completion:^(BOOL finished) {
             if (completion) completion();
         }];
    } else {
        window.rootViewController = viewController;
        if (completion) completion();
    }
}

#pragma mark - Notification
- (void)registerNotifications
{
    [self tme_registerNotifications:@{TMEUserDidLoginNotification:
                                          NSStringFromSelector(@selector(handleUserDidLoginNotification:)),

                                      }];
}

- (void)handleUserDidLoginNotification:(NSNotification *)note
{
    [self showHomeViewController];

    // FIXME: This is for push notification
    if (note.userInfo && [note.userInfo objectForKey:@"index"]) {
        NSNumber *index = [note.userInfo objectForKey:@"index"];

        UITabBarController *homeController = (UITabBarController *)self.deckController.centerController;
        [homeController setSelectedIndex:[index integerValue]];
    }
}

// TODO: Refactor
- (void)updateUAAlias
{
    [UAPush shared].alias = [NSString stringWithFormat:@"user-%d", [[TMEUserManager sharedManager].loggedUser.userID integerValue]];
    [[UAPush shared] updateRegistration];

}

@end
