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
#import "TMEPageViewController.h"
#import "TMEHomeNavigationViewController.h"

@interface TMERootAppDelegateService ()

@property (strong, nonatomic) IIViewDeckController *deckController;

@end

@implementation TMERootAppDelegateService

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self registerNotifications];
        [self setMaxConcurrencyRequest];
        [self setNetworkingStatusBarActivityIndicator];
    }
    
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.appDelegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UIWindow *window = self.appDelegate.window;
    
    if ([TMEUserManager sharedManager].loggedUser) {
        [self showHomeViewController];
    } else {
        [self showLoginViewController];
    }
    
    [window makeKeyAndVisible];
    
#ifdef DEBUG
    [[FLEXManager sharedManager] showExplorer];
#endif
    
    return YES;
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
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
    TMEPageViewController *pageVC = [[TMEPageViewController alloc] init];
    TMEHomeNavigationViewController *homeNC = [[TMEHomeNavigationViewController alloc] initWithRootViewController:pageVC];
    
    IIViewDeckController *deckController =  [[IIViewDeckController alloc] initWithCenterViewController:homeNC leftViewController:nil];
    
    self.deckController = deckController;
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
    
    //    [self updateUAAlias];
    [self switchRootViewController:self.deckController animated:YES completion:nil];
}

#pragma mark - Helper
- (AppDelegate *)appDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (IIViewDeckController *)deckController
{
    if (!_deckController) {
        TMELeftMenuViewController* leftController = [[TMELeftMenuViewController alloc] init];
        
        TMEHomeViewController *rootVC = [[TMEHomeViewController alloc] init];
        
        IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:rootVC leftViewController:leftController];
        
        [deckController setNavigationControllerBehavior:IIViewDeckNavigationControllerIntegrated];
        [deckController setCenterhiddenInteractivity:IIViewDeckCenterHiddenNotUserInteractiveWithTapToCloseBouncing];
        
        _deckController = deckController;
    }
    
    return _deckController;
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
                                      TMEUserDidLogoutNotification:
                                          NSStringFromSelector(@selector(handleUserDidLogoutNotification:)),
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

- (void)handleUserDidLogoutNotification:(NSNotification *)note
{
    [self showLoginViewController];
}

- (void)setMaxConcurrencyRequest
{
    [[[AFHTTPRequestOperationManager manager] operationQueue] setMaxConcurrentOperationCount:4];
}

- (void)setNetworkingStatusBarActivityIndicator
{
    // Manages the state of the network activity indicator in the status bar
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

@end
