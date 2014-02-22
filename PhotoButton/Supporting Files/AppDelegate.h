//
//  AppDelegate.h
//  PhotoButton
//
//  Created by Andrey Tabachnik on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMEHomeViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)sharedDelegate;

- (void)showHomeViewController;
- (void)showLoginView;

// Facebook stuff
- (void)openSession;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
