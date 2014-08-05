//
//  TMEActivityManager.h
//  ThreeMin
//
//  Created by Khoa Pham on 8/4/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEBaseManager.h"

@interface TMEActivityManager : TMEBaseManager

OMNIA_SINGLETON_H(sharedManager)

- (void)getActivitiesWithSuccess:(TMENetworkManagerArraySuccessBlock)success
                         failure:(TMENetworkManagerFailureBlock)failure;

@end
