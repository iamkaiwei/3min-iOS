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
                             failure:(TMEFailureBlock)failure {
    [[TMEFacebookManager sharedManager] signInWithSuccess: ^(NSString *facebookToken) {
        [self loginWithFacebookToken:facebookToken
                             success:success
                             failure:failure];
    } failure: ^(NSError *error) {
    }];
}

- (void)loginWithGooglePlusWithSuccess:(TMESuccessBlock)success
                               failure:(TMEFailureBlock)failure {
    [[TMEGooglePlusManager sharedManager] signInWithSuccess: ^(NSString *googlePlusToken)
     {
         [self loginWithGooglePlusToken:googlePlusToken
                                success:success
                                failure:failure];
     }                                               failure: ^(NSError *error) {
     }];
}

#pragma mark - Core
- (void)loginWithFacebookToken:(NSString *)facebookToken
                       success:(TMESuccessBlock)success
                       failure:(TMEFailureBlock)failure {
    NSDictionary *params = @{ @"fb_token": facebookToken, };
    
    [self loginWithParams:params success:success failure:failure];
}

- (void)loginWithGooglePlusToken:(NSString *)googlePlusToken
                         success:(TMESuccessBlock)success
                         failure:(TMEFailureBlock)failure {
    NSDictionary *params = @{ @"gg_token": googlePlusToken };
    
    [self loginWithParams:params success:success failure:failure];
}

- (void)loginWithParams:(NSDictionary *)params
                success:(TMESuccessBlock)success
                failure:(TMEFailureBlock)failure {
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
                                    success: ^(id responseObject)
     {
         // put every information at the same hierarchy level
         NSMutableDictionary *dicInfo = [NSMutableDictionary dictionaryWithDictionary:responseObject];
         [dicInfo addEntriesFromDictionary:responseObject[@"user"]];
         
         TMEUser *user = [TMEUser tme_modelFromJSONResponse:dicInfo];
         user.accessTokenReceivedAt = [NSDate date];
         
         [TMEUserManager sharedManager].loggedUser = user;
         [[TMEUserManager sharedManager] save];
         
         [[TMENetworkManager sharedManager] updateAuthorizationHeader];
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success();
             });
         }
     }
                                    failure: ^(NSError *error) {
                                        if (failure) {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                failure(error);
                                            });
                                        }
                                    }];
}

- (void)getFullInformationWithUserID:(NSUInteger)userID
                             success:(void (^)(TMEUser *user))success
                             failure:(TMEFailureBlock)failure {
    NSString *path = [NSString stringWithFormat:@"%@%@/%d", API_BASE_URL, API_USER, userID];
    
    [[TMENetworkManager sharedManager] get:path params:@{} success: ^(NSDictionary *responseObject) {
        TMEUser *parsingUser = [MTLJSONAdapter modelOfClass:[TMEUser class] fromJSONDictionary:responseObject error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success(parsingUser);
            }
        });
    } failure: ^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failure) {
                failure(error);
            }
        });
    }];
}

- (void)getFollowingsWithUserID:(NSUInteger)userID
                           page:(NSUInteger)page
                        success:(void (^)(NSArray *arrFollowings))success
                        failure:(TMEFailureBlock)failure {
    NSString *path = [NSString stringWithFormat:@"%@%@/%d/followings", API_BASE_URL, API_USER, userID];
    
    NSDictionary *params = @{
                             @"page": @(page)
                             };
    
    [[TMENetworkManager sharedManager] get:path params:params success: ^(id responseObject) {
        NSArray *arrFollowings = [MTLJSONAdapter modelsOfClass:[TMEUser class] fromJSONArray:responseObject error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success(arrFollowings);
            }
        });
    } failure: ^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failure) {
                failure(error);
            }
        });
    }];
}

- (void)getFollowersWithUserID:(NSUInteger)userID
                          page:(NSUInteger)page
                       success:(void (^)(NSArray *arrFollowings))success
                       failure:(TMEFailureBlock)failure {
    NSString *path = [NSString stringWithFormat:@"%@%@/%d/followers", API_BASE_URL, API_USER, userID];
    
    NSDictionary *params = @{
                             @"page": @(page)
                             };
    
    [[TMENetworkManager sharedManager] get:path params:params success: ^(id responseObject) {
        NSArray *arrFollowings = [MTLJSONAdapter modelsOfClass:[TMEUser class] fromJSONArray:responseObject error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success(arrFollowings);
            }
        });
    } failure: ^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failure) {
                failure(error);
            }
        });
    }];
}

- (void)followUser:(TMEUser *)user finishBlock:(void (^)(NSError *error))finishBlock {
    NSDictionary *params = @{
                             @"user_id": user.userID
                             };
    
    [[TMENetworkManager sharedManager] post:API_RELATIONSHIPS_FOLLOW params:params success: ^(id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (finishBlock) {
                finishBlock(nil);
            }
        });
    } failure: ^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (finishBlock) {
                finishBlock(error);
            }
        });
    }];
}

- (void)unfollowUser:(TMEUser *)user finishBlock:(void (^)(NSError *error))finishBlock {
    NSDictionary *params = @{
                             @"user_id": user.userID
                             };
    
    [[TMENetworkManager sharedManager] delete:API_RELATIONSHIPS_UNFOLLOW params:params success: ^(id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (finishBlock) {
                finishBlock(nil);
            }
        });
    } failure: ^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (finishBlock) {
                finishBlock(error);
            }
        });
    }];
}

@end
