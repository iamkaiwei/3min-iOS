//
//  AppDelegate+Logic.h
//  ThreeMin
//
//  Created by Bá Toàn on 3/27/14.
//
//

#import "AppDelegate.h"

@interface AppDelegate (Logic)



- (void)showLoginView;

// Facebook stuff
- (void)openSession;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)showTutorialController;
- (void)updateUAAlias;

- (void)switchRootViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)())completion;

@end
