//
//  TMEUserManager.h
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "BaseManager.h"

static NSString * const LAST_LOGIN_TIMESTAMP_STORED_KEY     = @"LAST_LOGIN_TIMESTAMP_STORED_KEY";
static NSString * const LAST_LOGIN_FACEBOOK_TOKEN           = @"LAST_LOGIN_FACEBOOK_TOKEN";
static NSString * const LAST_LOGIN_ACCESS_TOKEN             = @"LAST_LOGIN_ACCESS_TOKEN";
static NSString * const LAST_LOGIN_USER_ID                  = @"LAST_LOGIN_USER_ID";

typedef void (^TMEJSONLoginRequestSuccessBlock) (TMEUser *user);
typedef void (^TMEJSONLoginFailureSuccessBlock) (NSInteger statusCode, id obj);

@interface TMEUserManager : BaseManager

@property (assign, nonatomic) id<FBGraphUser>             loggedFacebookUser;
@property (strong, nonatomic) TMEUser                   * loggedUser;

- (NSString *)getFacebookToken;
- (NSString *)getAccessToken;
- (NSString *)getFacebookID;
- (NSString *)getUDID;


- (void)getUserWithID:(NSNumber *)userID onSuccess:(void (^)(TMEUser *user))successBlock andFailure:(TMEJSONRequestFailureBlock)failureBlock;
// login
- (void)loginBySendingFacebookWithSuccessBlock:(TMEJSONLoginRequestSuccessBlock)successBlock
                               andFailureBlock:(TMEJSONLoginFailureSuccessBlock)failureBlock;

- (void)setLoggedUser:(TMEUser *)loggedUser andFacebookUser:(id<FBGraphUser>)user;
- (void)logOut;
- (BOOL)isLoggedUser;

@end
