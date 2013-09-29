//
//  TMEUserManager.m
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "TMEUserManager.h"

@interface TMEUserManager()

@property (assign, nonatomic) BOOL                              isLogging;

@end

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

- (void)loginBySendingFacebookWithSuccessBlock:(TMEJSONLoginRequestSuccessBlock)successBlock andFailureBlock:(TMEJSONLoginFailureSuccessBlock)failureBlock{
    
    // prevent login but dont needed
    if (self.loggedUser && successBlock) {
        successBlock(self.loggedUser);
    }
    
    // prevent request login more then 1 time at the same time
    if (self.isLogging) {
        return;
    }
    
    self.isLogging = YES;
    
    NSDictionary *params = @{
                             @"fb_token": [[TMEUserManager sharedInstance] getFacebookToken],
                             @"udid": [[TMEUserManager sharedInstance] getUDID],
                             @"client_secret": API_CLIENT_SERCET,
                             @"client_id": API_CLIENT_ID,
                             @"grant_type": API_GRANT_TYPE};
    
    NSString *path = [NSString stringWithFormat:@"%@%@", API_SERVER_HOST, API_USER_LOGIN];
    
    [[BaseNetworkManager sharedInstance] sendRequestForPath:path parameters:params method:POST_METHOD success:^(NSHTTPURLResponse *response, id responseObject) {
        
        TMEUser *user = [TMEUser MR_createEntity];
        if (responseObject)
            user = [TMEUser userByFacebookDictionary:responseObject];
        
        [self setLoggedUser:user andFacebookUser:nil];
        
        // broadcast
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FINISH_LOGIN object:user];
        
        if (successBlock)
            successBlock(user);
        
        self.isLogging = NO;
        
    } failure:^(NSError *error) {
        
        if (failureBlock)
            failureBlock(error.code, error);
        
        self.isLogging = NO;
        
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
