//
//  TMEPushNotificationAppDelegateService.m
//  ThreeMin
//
//  Created by Khoa Pham on 7/16/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEPushNotificationAppDelegateService.h"
#import "UAirship.h"
#import "UAConfig.h"
#import "UAPush.h"
#import <Orbiter/Orbiter.h>

@interface TMEPushNotificationAppDelegateService () <UAPushNotificationDelegate>

@end

@implementation TMEPushNotificationAppDelegateService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Populate AirshipConfig.plist with your app's info from https://go.urbanairship.com
    // or set runtime properties here.
    UAConfig *config = [UAConfig defaultConfig];

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
    [UAPush shared].pushNotificationDelegate = self;

    return YES;
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

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
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

#warning THIS PART NEED TO BE CHECKED LATER
//    TMEConversation *notificationConversation = [[TMEConversation MR_findByAttribute:@"id" withValue:conversationID] lastObject];
//    TMEProduct *notificationProduct = [[TMEProduct MR_findByAttribute:@"id" withValue:productID] lastObject];
//
//    if (state == UIApplicationStateActive) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RELOAD_CONVERSATION object:nil];
//
//        [TSMessage dismissActiveNotification];
//
//        if ([alert length] > 40) {
//            alert = [[alert substringToIndex: 40] stringByAppendingString:@"..."];
//        }
//
//        [TSMessage showNotificationInViewController:homeController
//                                              title:alert
//                                           subtitle:nil
//                                              image:nil
//                                               type:TSMessageNotificationTypeMessage
//                                           duration:4.0f
//                                           callback:^
//         {
//             if (notificationConversation && notificationProduct) {
//                 TMESubmitViewController *submitVC = [[TMESubmitViewController alloc] init];
//                 submitVC.conversation = notificationConversation;
//                 submitVC.product = notificationProduct;
//
//                 [navController pushViewController:submitVC animated:YES];
//                 return;
//             }
//
//             [[NSNotificationCenter defaultCenter] postNotificationName:TMEShowHomeViewControllerNotification
//                                                                 object:nil
//                                                               userInfo:@{@"index": @(3)
//                                                                          }];
//
//         }
//                                        buttonTitle:nil
//                                     buttonCallback:nil
//                                         atPosition:TSMessageNotificationPositionTop
//                                canBeDismisedByUser:YES];
//        return;
//    }
//
//    if (notificationConversation && notificationProduct) {
//        TMESubmitViewController *submitVC = [[TMESubmitViewController alloc] init];
//        submitVC.conversation = notificationConversation;
//        submitVC.product = notificationProduct;
//
//        [navController pushViewController:submitVC animated:YES];
//        return;
//    }
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:TMEShowHomeViewControllerNotification
//                                                        object:nil
//                                                      userInfo:@{@"index": @(3)
//                                                                 }];

}

#pragma mark - Helper
- (void)displayNotificationAlert:(NSString *)alertMessage{
    return;
}

- (void)updateUAAlias{
    [UAPush shared].alias = [NSString stringWithFormat:@"user-%d", [[TMEUserManager sharedManager].loggedUser.userID integerValue]];
    [[UAPush shared] updateRegistration];
}


@end
