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
#import "AFUrbanAirshipClient.h"
#import "TMESubmitViewController.h"

@interface AppDelegate()
<
FacebookManagerDelegate
>

@property (strong, nonatomic) TMENavigationViewController               * navController;
@property (retain, nonatomic) UIViewController                          * centerController;
@property (retain, nonatomic) UIViewController                          * leftController;
@property (retain, nonatomic) IIViewDeckController                      * deckController;

@property (readonly, strong, nonatomic) NSManagedObjectContext          * managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel            * managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator    * persistentStoreCoordinator;

@end

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize window = _window;

+ (AppDelegate *)sharedDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    AFUrbanAirshipClient *client = [[AFUrbanAirshipClient alloc] initWithApplicationKey:URBAN_AIRSHIP_APP_KEY
                                                                      applicationSecret:URBAN_AIRSHIP_APP_SECRET];
    NSNumber *logginUserID = [[[TMEUserManager sharedInstance] loggedUser] id];
    NSString *alias = [NSString stringWithFormat:@"user-%d", [logginUserID integerValue]];
    [client registerDeviceToken:deviceToken withAlias:alias success:^{
        DLog(@"Urban Airship registered device token successfully");
    } failure:^(NSError *error) {
        DLog(@"Urban Airship failed to register device token. Error: %@", error);
    }];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    DLog(@"FailToRegisterForRemoteNotification: %@", error.description);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [TMEReachabilityManager sharedInstance];
    
    self.deckController = [self generateControllerStack];
    
    // Crittercism
    [Crittercism enableWithAppID: @"51f8bef646b7c2316f000007"];
    
    // start MR
    [MagicalRecord setupCoreDataStack];
    
    // Google analytics
    [self setUpGoogleAnalytics];
    
    // VCs stuff
    // Make the color of Navigation bar no more effects the status bar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque
                                                animated:NO];
    
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
  
    IIViewDeckController *deckController = (IIViewDeckController *)self.window.rootViewController;
    UITabBarController *homeController = (UITabBarController *)deckController.centerController;
    UINavigationController *navController = (UINavigationController *) [[homeController viewControllers] objectAtIndex:0];
    
    if (state == UIApplicationStateActive) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RELOAD_CONVERSATION object:nil];
        NSString *message = [NSString stringWithFormat:@"%@", alert];
        [TSMessage showNotificationWithTitle:message type:TSMessageNotificationTypeMessage];
        return;
    }
    
    if ([navController.topViewController isMemberOfClass:[TMESubmitViewController class]])
    {
        TMESubmitViewController *submitVC = (TMESubmitViewController *)navController.topViewController;
        if ([submitVC.conversation.id isEqual:userInfo[@"aps"][@"other"][@"conversation_id"]]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RELOAD_CONVERSATION object:nil];
            return;
        }
    }
  
    TMEConversation *notificationConversation = [[TMEConversation MR_findByAttribute:@"id" withValue:@900] lastObject];
    TMEProduct *notificationProduct = [[TMEProduct MR_findByAttribute:@"id" withValue:@900] lastObject];
  
    if (notificationConversation && notificationProduct) {
      TMESubmitViewController *submitVC = [[TMESubmitViewController alloc] init];
      submitVC.conversation = notificationConversation;
      submitVC.product = notificationProduct;
    
      [navController pushViewController:submitVC animated:YES];
    }
  
    [self showHomeViewController];
    deckController = (IIViewDeckController *)self.window.rootViewController;
    homeController = (UITabBarController *)deckController.centerController;
    [homeController setSelectedIndex:3];
  
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
#pragma mark - Generate ViewController stack

- (IIViewDeckController*)generateControllerStack {
    
    TMELeftMenuViewController* leftController = [[TMELeftMenuViewController alloc] init];
    
    // Set up ViewDeck central
    TMEHomeViewController *rootVC = [[TMEHomeViewController alloc] init];
    
    IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:rootVC leftViewController:leftController];
    
    [deckController setNavigationControllerBehavior:IIViewDeckNavigationControllerIntegrated];
    [deckController setCenterhiddenInteractivity:IIViewDeckCenterHiddenNotUserInteractiveWithTapToCloseBouncing];
    
    deckController.rightSize = 60;
    
    self.leftController = deckController.leftController;
    self.centerController = deckController.centerController;
    self.navController = (TMENavigationViewController *)deckController.centerController;
    
    return deckController;
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ThreeMins" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ThreeMins.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark - Facebook

- (void)checkFacebookSessionAtTheAppLaunch
{
    // Facebook Stuffs
    [FBLoginView class];
    [FacebookManager sharedInstance].delegate = (id) self;
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        
        [self openSession];
        [self showHomeViewController];
        
    } else {
        // No, display the login page.
        [self showLoginView];
    }
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}

- (void)openSession
{
    [[FacebookManager sharedInstance] openSession];
}

- (void)showLoginView
{
    TMELoginViewController* loginViewController = [[TMELoginViewController alloc]init];
    [self switchRootViewController:loginViewController animated:YES completion:nil];
    [self.window makeKeyAndVisible];
}

#pragma mark - Google Analytics
- (void)setUpGoogleAnalytics
{
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 20;
    [GAI sharedInstance].debug = YES;
    [[GAI sharedInstance] trackerWithTrackingId:GOOGLE_ANALYTICS_APP_KEY];
    [GAI sharedInstance].debug = YES;
}

#pragma mark - ViewController change helpers
- (void)switchRootViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)())completion
{
    if (animated) {
        [UIView transitionWithView:self.window duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            BOOL oldState = [UIView areAnimationsEnabled];
            [UIView setAnimationsEnabled:NO];
            self.window.rootViewController = viewController;
            [UIView setAnimationsEnabled:oldState];
        } completion:^(BOOL finished) {
            if (completion) completion();
        }];
    } else {
        self.window.rootViewController = viewController;
        if (completion) completion();
    }
}

#pragma mark - Switch View Controllers

- (void)configTabbarAndNavigationBar
{
    // config tabbar appear
    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbar-background"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)showHomeViewController
{
    [self configTabbarAndNavigationBar];
    
    if ([FBSession.activeSession isOpen] == NO) {
        [self showLoginView];
        return;
    } else if (![[TMEUserManager sharedInstance] loggedUser]) {
        [SVProgressHUD showWithStatus:@"Login..." maskType:SVProgressHUDMaskTypeGradient];
        [[TMEUserManager sharedInstance] loginBySendingFacebookWithSuccessBlock:^(TMEUser *tmeUser) {
            [SVProgressHUD showSuccessWithStatus:@"Login successfully"];
            [[TMEUserManager sharedInstance] setLoggedUser:tmeUser andFacebookUser:nil];
            
            [SVProgressHUD dismiss];
            [self switchRootViewController:self.deckController animated:YES completion:nil];
            UITabBarController *tabBarController = (UITabBarController *)self.deckController.centerController;
            tabBarController.selectedIndex = 0;
        } andFailureBlock:^(NSInteger statusCode, id obj) {
            [SVProgressHUD showErrorWithStatus:@"Login failure"];
        }];
    } else {
      [self switchRootViewController:self.deckController animated:YES completion:nil];
    }
}

- (void)showTutorialController
{
    [self switchRootViewController:[[TMETutorialViewController alloc] init] animated:YES completion:nil];
}

@end
