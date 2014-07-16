//
//  AppDelegate.h
//  PhotoButton
//
//  Created by Andrey Tabachnik on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow * window;

+ (AppDelegate *)sharedDelegate;

@end
