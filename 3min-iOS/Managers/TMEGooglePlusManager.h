//
//  TMEGooglePlusManager.h
//  ThreeMin
//
//  Created by Khoa Pham on 8/12/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEBaseManager.h"

@interface TMEGooglePlusManager : TMEBaseManager

OMNIA_SINGLETON_H(sharedManager)

- (void)setup;
- (void)signIn;
- (void)signOut;


@end
