//
//  AppDelegate+Logic.h
//  ThreeMin
//
//  Created by Bá Toàn on 3/27/14.
//
//

#import "AppDelegate.h"

@interface AppDelegate (Logic)

@property (strong, nonatomic) NSManagedObjectContext       * managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel         * managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator * persistentStoreCoordinator;

- (void)showLoginView;

// Facebook stuff
- (void)openSession;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (IIViewDeckController*)generateControllerStack;
- (void)checkFacebookSessionAtTheAppLaunch;
- (void)initFourSquare;
- (void)showTutorialController;
- (void)setUpGoogleAnalytics;
- (void)updateUAAlias;

- (void)switchRootViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)())completion;

@end
