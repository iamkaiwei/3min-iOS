//
//  TMEUserManager.m
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "TMEUserManager.h"

@implementation TMEUserManager

SINGLETON_MACRO

#pragma marks - Login/logout
- (BOOL)isLoggedUser
{
    if (self.loggedUser)
        return YES;
    
    return NO;
}

- (void)setLoggedUser:(TMEUser *)loggedUser andFacebookUser:(id<FBGraphUser>)user
{
    self.loggedUser = loggedUser;
    self.loggedFacebookUser = user;
}

- (void)logOut
{
    self.loggedUser = nil;
    self.loggedFacebookUser = nil;
}

- (NSString *)getFacebookToken
{
    return [[[FBSession activeSession] accessTokenData] accessToken];
}

- (NSString *)getAccessToken{
    return self.loggedUser.access_token;
}

- (NSString *)getUDID
{
    return [OpenUDID value];
}

- (NSString *)getFacebookID
{
    return self.loggedUser.facebook_id;
}

- (void)loginBySendingFacebookToken:(NSString *)token withSuccessBlock:(TMEJSONLoginRequestSuccessBlock)successBlock andFailureBlock:(TMEJSONLoginFailureSuccessBlock)failureBlock{
    
    NSDictionary *params = @{
                             @"fb_token": [[TMEUserManager sharedInstance] getFacebookToken],
                             @"udid": [[TMEUserManager sharedInstance] getUDID],
                             @"client_secret": API_CLIENT_SERCET,
                             @"client_id": API_CLIENT_ID,
                             @"grant_type": API_GRANT_TYPE};
    
    [[BaseNetworkManager sharedInstance] sendRequestForPath:API_USER_LOGIN parameters:params method:POST_METHOD success:^(NSHTTPURLResponse *response, id responseObject) {
        
        TMEUser *user = [TMEUser MR_createEntity];
        if (responseObject)
            user = [TMEUser userByFacebookDictionary:responseObject];
        
        if (successBlock)
            successBlock(user);
        
    } failure:^(NSError *error) {
        
        if (failureBlock)
            failureBlock(error.code, error);
        
    }];
    
}

#pragma marks - Fake functions to handle users stuffs
- (TMEUser *)userWithDictionary:(NSDictionary *)dicData
{
    TMEUser *user = [TMEUser MR_createEntity];
    user.name = dicData[@"name"];
    user.id = @([[TMEUserManager sharedInstance] getTheLargestUserID]);
    return user;
}

#pragma marks - Helper metholds
- (NSInteger)getTheLargestUserID
{
    TMEUser *user = [[TMEUser MR_findAll] lastObject];
    if (user) {
        return [user.id intValue] + 1;
    }
    return 1;
}

@end
