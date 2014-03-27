//
//  AppDelegate+Logic.m
//  ThreeMin
//
//  Created by Bá Toàn on 3/27/14.
//
//

#import "AppDelegate+Logic.h"
#import "GAI.h"
#import "TMETutorialViewController.h"

@implementation AppDelegate (Logic)

@dynamic managedObjectContext;
@dynamic managedObjectModel;
@dynamic persistentStoreCoordinator;

#pragma mark - Version checker

- (void)initVersionChecker
{
    [VENVersionTracker beginTrackingVersionForChannel:@"internal"
                                       serviceBaseUrl:@"https://www.dropbox.com/sh/ijwghminfsqwd0n/s3t44SLYPf/version"
                                         timeInterval:1800
                                          withHandler:^(VENVersionTrackerState state, VENVersion *version) {

                                              dispatch_sync(dispatch_get_main_queue(), ^{
                                                  switch (state) {
                                                      case VENVersionTrackerStateDeprecated:
                                                          [version install];
                                                          break;

                                                      case VENVersionTrackerStateOutdated:
                                                      {
                                                          // Offer the user the option to update
                                                          UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Update required", nil) message:NSLocalizedString(@"There is a newer version, please update to get the best experience", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
                                                          [alertView show];

                                                          break;
                                                      }
                                                      default:
                                                          break;
                                                  }
                                              });
                                          }];
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
    return deckController;
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (self.managedObjectContext != nil) {
        return self.managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        self.managedObjectContext = [[NSManagedObjectContext alloc] init];
        [self.managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return self.managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (self.managedObjectModel != nil) {
        return self.managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ThreeMins" withExtension:@"momd"];
    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return self.managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (self.persistentStoreCoordinator != nil) {
        return self.persistentStoreCoordinator;
    }

    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ThreeMins.sqlite"];

    NSError *error = nil;
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    return self.persistentStoreCoordinator;
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
    NSString *specifier = [[url resourceSpecifier] lowercaseString];

    if ([specifier contains:@"foursquare"]) {
        return [Foursquare2 handleURL:url];
    }

    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}

- (void)openSession
{
    [[FacebookManager sharedInstance] openSession];
}

- (void)showLoginView
{
    TMETutorialViewController *loginViewController = [[TMETutorialViewController alloc] init];
    [self switchRootViewController:loginViewController animated:YES completion:nil];
    [self.window makeKeyAndVisible];
}

#pragma mark - Google Analytics
- (void)setUpGoogleAnalytics
{
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 20;
    //    [GAI sharedInstance].debug = YES;
    [[GAI sharedInstance] trackerWithTrackingId:GOOGLE_ANALYTICS_APP_KEY];
    //    [GAI sharedInstance].debug = YES;
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

#pragma mark - Foursquare initialization

- (void)initFourSquare
{
    [Foursquare2 setupFoursquareWithClientId:@"UTG1422BL21NVOSHA24C2FGEQXVYWYWXHBSSP0XNBSLVPIAM"
                                      secret:@"PMK2RVQ5EEOJH3ZVINAIDUZPXR3QZED3MYDRWMQYQDCOMR0W"
                                 callbackURL:@"3mins://foursquare"];
}

#pragma mark - Switch View Controllers

- (void)pusher:(PTPusher *)pusher willAuthorizeChannel:(PTPusherChannel *)channel withRequest:(NSMutableURLRequest *)request{
    [request setValue:[NSString stringWithFormat:@"Bearer %@",[[TMEUserManager sharedInstance] getAccessToken]] forHTTPHeaderField:@"Authorization"];
}

- (void)handleTapOnNotificationWithConversation:(TMEConversation *)conversation andProduct:(TMEProduct *)product{

}

- (void)showTutorialController
{
    [self switchRootViewController:[[TMETutorialViewController alloc] init] animated:YES completion:nil];
}

@end
