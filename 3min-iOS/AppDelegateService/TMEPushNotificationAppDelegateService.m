//
//  TMEPushNotificationAppDelegateService.m
//  ThreeMin
//
//  Created by Khoa Pham on 7/16/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEPushNotificationAppDelegateService.h"
#import <Orbiter/Orbiter.h>
#import "TMEPushNotificationManager.h"
#import "TMEProductDetailOnlyTableVC.h"

@interface TMEPushNotificationAppDelegateService () 

@end

@implementation TMEPushNotificationAppDelegateService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if !TARGET_IPHONE_SIMULATOR
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) { // iOS 8 and later...
        UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    else {
        UIRemoteNotificationType types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:types];
    }
#endif
    
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
    NSLog(@"remote notification payload:\n%@", userInfo);
    [self handleRemoteNotificationWithPayload:userInfo];
}

#pragma mark - Handle Remote Notification

- (void)handleRemoteNotificationWithPayload:(NSDictionary *)payload
{
    if (!payload) {
        return;
    }
    
    // reset application badge number
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // application state
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    if (state == UIApplicationStateActive) {
        // payload
        NSString *alertMessage = payload[@"aps"][@"alert"];
        
        UINavigationController *navigationController = [self navigationController];
        UIViewController *topViewController = navigationController.topViewController;
        [TSMessage showNotificationInViewController:topViewController
                                              title:nil
                                           subtitle:alertMessage
                                              image:nil
                                               type:TSMessageNotificationTypeMessage
                                           duration:TSMessageNotificationDurationEndless
                                           callback:nil
                                        buttonTitle:NSLocalizedString(@"View", nil)
                                     buttonCallback:^{
                                         [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RELOAD_CONVERSATION
                                                                                             object:nil];
                                     }
                                         atPosition:TSMessageNotificationPositionTop
                                canBeDismisedByUser:YES];
        return;
    }
    
    // detail
    NSString *productID = payload[@"aps"][@"other"][@"product_id"];
    if (productID.length > 0) {
        [self navigateToProductDetailsWithProductID:productID];
    }
    else {
        // conversation
        NSString *conversationID = payload[@"aps"][@"other"][@"conversation_id"];
        if (conversationID.length > 0) {
            [self navigateToProductDetailsWithConversationID:conversationID];
        }
    }
}

#pragma mark - Navigate

- (void)navigateToProductDetailsWithConversationID:(NSString *)conversationID
{
    TMEProductDetailOnlyTableVC *productViewController = [TMEProductDetailOnlyTableVC tme_instantiateFromStoryboardNamed:@"TMEProductDetailOnlyTableVC"];
    UINavigationController *navigationController = [self navigationController];
    [navigationController pushViewController:productViewController animated:YES];
}

- (void)navigateToProductDetailsWithProductID:(NSString *)productID
{
    TMESubmitViewController *submitViewController = [[TMESubmitViewController alloc] init];
    UINavigationController *navigationController = [self navigationController];
    [navigationController pushViewController:submitViewController animated:YES];
}

#pragma mark - Private

- (UINavigationController *)navigationController
{
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    IIViewDeckController *deckController = (IIViewDeckController *)keyWindow.rootViewController;
    UINavigationController *navigationController = (UINavigationController *)deckController.centerController;
    return navigationController;
}

@end
