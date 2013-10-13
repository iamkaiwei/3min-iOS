//
//  TMEUserManager.m
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "TMEUserManager.h"

static NSString * const LAST_LOGIN_TIMESTAMP_STORED_KEY     = @"LAST_LOGIN_TIMESTAMP_STORED_KEY";
static NSString * const LAST_LOGIN_FACEBOOK_TOKEN           = @"LAST_LOGIN_FACEBOOK_TOKEN";
static NSString * const LAST_LOGIN_ACCESS_TOKEN             = @"LAST_LOGIN_ACCESS_TOKEN";
static double const AVAIABLE_TOKEN_TIME_TO_EXPIRED           = 7200;

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
    
    if (![self isAccessTokenExpired]) {
        TMEUser *user = [TMEUser MR_createEntity];
        user.access_token = [self getAccessTokenFromStore];
        
        if (successBlock) {
            successBlock(user);
        }
        
        return;
    }
    
    [self sendNewLoginRequestWithSuccessBlock:successBlock
                              andFailureBlock:failureBlock];
    
}

- (void)sendNewLoginRequestWithSuccessBlock:(TMEJSONLoginRequestSuccessBlock)successBlock
                            andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
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
        if (responseObject){
            user = [TMEUser userByFacebookDictionary:responseObject];
            [self storeLastLoginWithFacebookToken:[self getFacebookToken]
                                      accessToken:user.access_token];
        }
        
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

#pragma mark - Improve login flow
- (BOOL)storeLastLoginWithFacebookToken:(NSString *)facebookToken
                            accessToken:(NSString *)accessToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:facebookToken forKey:LAST_LOGIN_FACEBOOK_TOKEN];
    [defaults setObject:accessToken forKey:LAST_LOGIN_ACCESS_TOKEN];
    [self storeTheLastLoginTimeStampWithtTimeIntervalSinceNow];
    return YES;
}
- (BOOL)isAccessTokenExpired
{
    NSTimeInterval currentTimeStamp = [[NSDate date] timeIntervalSince1970];
    
    NSTimeInterval lastLoginTimeStamp = [self getLastLoginTimestamp] + AVAIABLE_TOKEN_TIME_TO_EXPIRED;
    
    if (currentTimeStamp > lastLoginTimeStamp)
        return YES;
    
    return NO;
}

- (BOOL)storeTheLastLoginTimeStampWithtTimeIntervalSinceNow
{
    NSString *stringTimeStamp = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:stringTimeStamp forKey:LAST_LOGIN_TIMESTAMP_STORED_KEY];
    
    return YES;
}

- (NSTimeInterval)getLastLoginTimestamp
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *stringTimeStamp = [defaults objectForKey:LAST_LOGIN_TIMESTAMP_STORED_KEY];
    if ([stringTimeStamp isEqualToString:@""]) {
        return NSTimeIntervalSince1970;
    }
    
    NSTimeInterval lastLoginTimestamp = [stringTimeStamp doubleValue];
    return lastLoginTimestamp;
}

- (NSString *)getFacebookTokenFromStore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *facebookTokenString = [defaults objectForKey:LAST_LOGIN_FACEBOOK_TOKEN];
    return facebookTokenString;
}

- (NSString *)getAccessTokenFromStore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *accessToken = [defaults objectForKey:LAST_LOGIN_ACCESS_TOKEN];
    return accessToken;
}

@end
