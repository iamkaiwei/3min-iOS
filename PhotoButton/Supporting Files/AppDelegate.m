//
//  AppDelegate.m
//  PhotoButton
//
//  Created by Triệu Khang on 08/09/13.
//  Copyright (c) 2013 hasBrain. All rights reserved.
//

#import "AppDelegate.h"
#import "TMETutorialViewController.h"
#import "TMEHomeViewController.h"
#import "TMEUserManager.h"
#import "TMEReachabilityManager.h"
#import "GAI.h"
#import "TMESubmitViewController.h"
#import "UAirship.h"
#import "UAConfig.h"
#import "UAPush.h"

@interface AppDelegate()
<
FacebookManagerDelegate
>

//@property (strong, nonatomic) TMENavigationViewController * navController;
//@property (retain, nonatomic) UIViewController            * centerController;
//@property (retain, nonatomic) UIViewController            * leftController;
@property (strong, nonatomic) IIViewDeckController        * deckController;
//@property (strong, nonatomic) PTPusherPresenceChannel      * presenceChannel;

@end

@implementation AppDelegate

+ (AppDelegate *)sharedDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
//    AFUrbanAirshipClient *client = [[AFUrbanAirshipClient alloc] initWithApplicationKey:URBAN_AIRSHIP_APP_KEY
//                                                                      applicationSecret:URBAN_AIRSHIP_APP_SECRET];
//    NSNumber *logginUserID = [[[TMEUserManager sharedInstance] loggedUser] id];
//    NSString *alias = [NSString stringWithFormat:@"user-%d", [logginUserID integerValue]];
//    [client registerDeviceToken:deviceToken withAlias:alias success:^{
//        DLog(@"Urban Airship registered device token successfully");
//    } failure:^(NSError *error) {
//        DLog(@"Urban Airship failed to register device token. Error: %@", error);
//    }];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    DLog(@"FailToRegisterForRemoteNotification: %@", error.description);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Populate AirshipConfig.plist with your app's info from https://go.urbanairship.com
    // or set runtime properties here.
    UAConfig *config = [UAConfig defaultConfig];
    
    // You can also programmatically override the plist values:
    // config.developmentAppKey = @"YourKey";
    // etc.
    
    config.developmentAppKey = URBAN_AIRSHIP_APP_KEY_DEVELOPMENT;
    config.developmentAppSecret = URBAN_AIRSHIP_APP_SECRET_DEVELOPMENT;
    config.productionAppKey = URBAN_AIRSHIP_APP_KEY_PRODUCTION;
    config.productionAppSecret = URBAN_AIRSHIP_APP_SECRET_PRODUCTION;
    config.detectProvisioningMode = YES;

    // Call takeOff (which creates the UAirship singleton)
    [UAirship takeOff:config];

    // Request a custom set of notification types
    [UAPush shared].notificationTypes = (UIRemoteNotificationTypeBadge |
                                         UIRemoteNotificationTypeSound |
                                         UIRemoteNotificationTypeAlert);

    [[UAPush shared] setPushEnabled:YES];

    
    [TMEReachabilityManager sharedInstance];
    
    self.deckController = [self generateControllerStack];
    
    // Crittercism
    [Crittercism enableWithAppID: @"51f8bef646b7c2316f000007"];
    
    // Version checker
    //    [self initVersionChecker];
    
    // start MR
    [MagicalRecord setupCoreDataStack];
    
    // start foursquare
    [self initFourSquare];
    
    // Google analytics
    [self setUpGoogleAnalytics];
    
    // VCs stuff
    // Make the color of Navigation bar no more effects the status bar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque
                                                animated:NO];
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation_background"] forBarMetrics:UIBarMetricsDefault];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if (![TMETutorialViewController hasBeenPresented]) {
        [self showTutorialController];
        [self.window makeKeyAndVisible];
        return YES;
    }
    
    [self checkFacebookSessionAtTheAppLaunch];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSession.activeSession handleDidBecomeActive];
    [FBAppEvents activateApp];
    [FBAppCall handleDidBecomeActive];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RELOAD_CONVERSATION object:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [FBSession.activeSession close];
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    
    NSString *alert = userInfo[@"aps"][@"alert"];
    NSString *productID = userInfo[@"aps"][@"other"][@"product_id"];
    NSString *conversationID = userInfo[@"aps"][@"other"][@"conversation_id"];
    
    IIViewDeckController __block *deckController = (IIViewDeckController *)self.window.rootViewController;
    UITabBarController __block *homeController = (UITabBarController *)deckController.centerController;
    UINavigationController *navController = (UINavigationController *) [homeController selectedViewController];
    
    if ([navController.topViewController isMemberOfClass:[TMESubmitViewController class]])
    {
        TMESubmitViewController *submitVC = (TMESubmitViewController *)navController.topViewController;
        if ([submitVC.conversation.id isEqual:conversationID]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RELOAD_CONVERSATION object:nil];
            return;
        }
    }
    
    TMEConversation *notificationConversation = [[TMEConversation MR_findByAttribute:@"id" withValue:conversationID] lastObject];
    TMEProduct *notificationProduct = [[TMEProduct MR_findByAttribute:@"id" withValue:productID] lastObject];
    
    if (state == UIApplicationStateActive) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RELOAD_CONVERSATION object:nil];
        
        if ([alert length] > 40) {
            alert = [[alert substringToIndex: 40] stringByAppendingString:@"..."];
        }
        
        [TSMessage showNotificationInViewController:homeController
                                              title:alert
                                           subtitle:nil
                                              image:nil
                                               type:TSMessageNotificationTypeMessage
                                           duration:4.0f
                                           callback:^
         {
             if (notificationConversation && notificationProduct) {
                 TMESubmitViewController *submitVC = [[TMESubmitViewController alloc] init];
                 submitVC.conversation = notificationConversation;
                 submitVC.product = notificationProduct;

                 [navController pushViewController:submitVC animated:YES];
                 return;
             }

             [self showHomeViewController];
             deckController = (IIViewDeckController *)self.window.rootViewController;
             homeController = (UITabBarController *)deckController.centerController;
             [homeController setSelectedIndex:3];

         }
                                        buttonTitle:nil
                                     buttonCallback:nil
                                         atPosition:TSMessageNotificationPositionTop
                                canBeDismisedByUser:YES];
        return;
    }

    if (notificationConversation && notificationProduct) {
        TMESubmitViewController *submitVC = [[TMESubmitViewController alloc] init];
        submitVC.conversation = notificationConversation;
        submitVC.product = notificationProduct;
        
        [navController pushViewController:submitVC animated:YES];
        return;
    }
    
    [self showHomeViewController];
    deckController = (IIViewDeckController *)self.window.rootViewController;
    homeController = (UITabBarController *)deckController.centerController;
    [homeController setSelectedIndex:3];
    
}

- (void)showHomeViewController
{
    if ([FBSession.activeSession isOpen] == NO) {
        [self showLoginView];
        return;
    } else if (![[TMEUserManager sharedInstance] loggedUser] && [TMEReachabilityManager isReachable]) {
        [SVProgressHUD showWithStatus:NSLocalizedString(@"Login...", nil) maskType:SVProgressHUDMaskTypeGradient];
        [[TMEUserManager sharedInstance] loginBySendingFacebookWithSuccessBlock:^(TMEUser *tmeUser) {
            [[TMEUserManager sharedInstance] setLoggedUser:tmeUser andFacebookUser:nil];
            [self updateUAAlias];
            [self switchRootViewController:self.deckController animated:YES completion:nil];
            UITabBarController *tabBarController = (UITabBarController *)self.deckController.centerController;
            tabBarController.selectedIndex = 0;
        } andFailureBlock:^(NSInteger statusCode, id obj) {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Login failed", nil)];
        }];
    } else if (![TMEReachabilityManager isReachable]) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"No connection!", nil)];
    } else {
        [self updateUAAlias];

        [self switchRootViewController:self.deckController animated:YES completion:nil];
    }
}

@end
