//
//  TMEUserNetworkClient.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/17/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEUserNetworkClient.h"
#import "TMEUserManager.h"
#import "TMEDeviceManager.h"

@implementation TMEUserNetworkClient

#pragma mark - Public Interface
- (void)loginWithFacebookWithSuccess:(TMESuccessBlock)success
                             failure:(TMEFailureBlock)failure
{
    [[TMEFacebookManager sharedManager] signInWithSuccess:^(NSString *facebookToken) {
        [self loginWithFacebookToken:facebookToken
                             success:success
                             failure:failure];
    } failure:^(NSError *error) {

    }];
}


- (void)loginWithGooglePlusWithSuccess:(TMEFailureBlock)success
                               failure:(TMEFailureBlock)failure
{
    [[TMEGooglePlusManager sharedManager] signInWithSuccess:^(NSString *googlePlusToken)
     {
         [self loginWithGooglePlusToken:googlePlusToken
                                success:success
                                failure:failure];
     } failure:^(NSError *error) {
         
     }];
}

#pragma mark - Core
- (void)loginWithFacebookToken:(NSString *)facebookToken
                       success:(TMESuccessBlock)success
                       failure:(TMEFailureBlock)failure
{
    NSDictionary *params = @{@"fb_token": facebookToken,
                             };

    [self loginWithParams:params success:success failure:failure];
}

- (void)loginWithGooglePlusToken:(NSString *)googlePlusToken
                         success:(TMESuccessBlock)success
                         failure:(TMEFailureBlock)failure
{
    NSDictionary *params = @{@"gg_token": googlePlusToken
                             };

    [self loginWithParams:params success:success failure:failure];
}

- (void)loginWithParams:(NSDictionary *)params
                success:(TMESuccessBlock)success
                failure:(TMEFailureBlock)failure
{
    NSDictionary *identityParams = @{
                                     @"udid": [TMEDeviceManager sharedManager].UDID,
                                     @"client_secret": API_CLIENT_SERCET,
                                     @"client_id": API_CLIENT_ID,
                                     @"grant_type": API_GRANT_TYPE
                                     };

    NSMutableDictionary *combinedParams = [NSMutableDictionary dictionaryWithDictionary:identityParams];
    [combinedParams addEntriesFromDictionary:params];

    NSString *path = [NSString stringWithFormat:@"%@%@", API_BASE_URL, API_USER_LOGIN];

    [[TMENetworkManager sharedManager] post:path
                                     params:combinedParams
                                    success:^(id responseObject)
    {
        TMEUser *user = [TMEUser tme_modelFromJSONResponse:responseObject];
        user.accessTokenReceivedAt = [NSDate date];

        [TMEUserManager sharedManager].loggedUser = user;
        [[TMEUserManager sharedManager] save];

        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
