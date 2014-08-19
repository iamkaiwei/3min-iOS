//
//  TMEUserNetworkClient.h
//  ThreeMin
//
//  Created by Khoa Pham on 8/17/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMEUserNetworkClient : NSObject

OMNIA_SINGLETON_H(sharedClient)

- (void)loginWithFacebookWithSuccess:(TMESuccessBlock)success
                             failure:(TMEFailureBlock)failure;

- (void)loginWithGooglePlusWithSuccess:(TMEFailureBlock)success
                               failure:(TMEFailureBlock)failure;

@end
