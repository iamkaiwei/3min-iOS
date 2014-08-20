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
#import "TMEPushNotificationManager.h"

@interface TMEPushNotificationAppDelegateService () <UAPushNotificationDelegate>

@end

@implementation TMEPushNotificationAppDelegateService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];

    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    UrbanAirshipOrbiter *urbanAirshipOrbiter = [UrbanAirshipOrbiter urbanAirshipManagerWithApplicationKey:URBAN_AIRSHIP_APP_KEY
                                                                                        applicationSecret:URBAN_AIRSHIP_APP_SECRET];
    NSString *alias = [NSString stringWithFormat:@"user-%d", [[TMEUserManager sharedManager].loggedUser.userID integerValue]];

    [urbanAirshipOrbiter registerDeviceToken:deviceToken
                                   withAlias:alias
                                     success:^(id responseObject)
    {
        DLog(@"Registration Success: %@", responseObject);
    } failure:^(NSError *error) {
        DLog(@"Registration Error: %@", error);
    }];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    DLog(@"FailToRegisterForRemoteNotification: %@", error.description);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // FIXME: handle push notification
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


@end
