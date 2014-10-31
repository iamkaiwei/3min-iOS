//
//  TMEUserNetworkClient.h
//  ThreeMin
//
//  Created by Khoa Pham on 8/17/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMEUserNetworkClient : NSObject

- (void)loginWithFacebookWithSuccess:(TMESuccessBlock)success
                             failure:(TMEFailureBlock)failure;

- (void)loginWithGooglePlusWithSuccess:(TMESuccessBlock)success
                               failure:(TMEFailureBlock)failure;

- (void)getFullInformationWithUserID:(NSUInteger)userID
                             success:(void (^)(TMEUser *user))success
                             failure:(TMEFailureBlock)failure;

@end
