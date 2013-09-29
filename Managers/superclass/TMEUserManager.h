//
//  TMEUserManager.h
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "BaseManager.h"

typedef void (^TMEJSONLoginRequestSuccessBlock) (TMEUser *user);
typedef void (^TMEJSONLoginFailureSuccessBlock) (NSInteger statusCode, id obj);

@interface TMEUserManager : BaseManager

@property (assign, nonatomic) id<FBGraphUser>             loggedFacebookUser;
@property (strong, nonatomic) TMEUser                   * loggedUser;

- (NSString *)getFacebookToken;
- (NSString *)getAccessToken;
- (NSString *)getFacebookID;
- (NSString *)getUDID;

// login
- (void)loginBySendingFacebookWithSuccessBlock:(TMEJSONLoginRequestSuccessBlock)successBlock
                               andFailureBlock:(TMEJSONLoginFailureSuccessBlock)failureBlock;

- (void)setLoggedUser:(TMEUser *)loggedUser andFacebookUser:(id<FBGraphUser>)user;
- (void)logOut;
- (BOOL)isLoggedUser;

@end
