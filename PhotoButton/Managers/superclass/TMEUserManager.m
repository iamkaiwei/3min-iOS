//
//  TMEUserManager.m
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "TMEUserManager.h"

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
  [[TMEFacebookManager sharedInstance] logout];
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
        NSNumber *userID = [self getUserIDFromStore];
        
        
        [self getUserWithID:userID
                  onSuccess:^(TMEUser *userRes)
         {
             userRes.access_token = [self getAccessTokenFromStore];
             if (successBlock) {
                 successBlock(userRes);
             }
         }
                 andFailure:^(NSInteger statusCode, NSError *error)
        {
            if (failureBlock) {
                failureBlock(statusCode, error);
            }
            [[TMEFacebookManager sharedInstance] logout];
            self.isLogging = NO;
        }];
      
        return;
    }
    
    [self sendNewLoginRequestWithSuccessBlock:successBlock
                              andFailureBlock:failureBlock];
    
}

- (void)getUserWithID:(NSNumber *)userID onSuccess:(void (^)(TMEUser *user))successBlock andFailure:(TMEJSONRequestFailureBlock)failureBlock
{
    NSDictionary *params = @{@"access_token": [self getAccessTokenFromStore]};
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@",API_SERVER_HOST,API_USER,userID];

    [[AFHTTPRequestOperationManager tme_manager] GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        TMEUser *user = [TMEUser userWithData:responseObject];
        
        if (successBlock) {
            successBlock(user);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failureBlock)
            failureBlock(error.code, error);
    }];
}

- (void)sendNewLoginRequestWithSuccessBlock:(TMEJSONLoginRequestSuccessBlock)successBlock
                            andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSDictionary *params = @{
                             @"fb_token": [[TMEUserManager sharedInstance] getFacebookToken],
                             @"udid": [[TMEUserManager sharedInstance] getUDID],
                             @"client_secret": API_CLIENT_SERCET,
                             @"client_id": API_CLIENT_ID,
                             @"grant_type": API_GRANT_TYPE};
    
    NSString *path = [NSString stringWithFormat:@"%@%@", API_BASE_URL, API_USER_LOGIN];

    [[AFHTTPRequestOperationManager tme_manager] POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        TMEUser *user;
        if (responseObject){
            user = [TMEUser userByFacebookDictionary:responseObject];
            [self storeLastLoginWithFacebookToken:[self getFacebookToken]
                                      accessToken:user.access_token
                                           userID:user.id];
            [self setLoggedUser:user andFacebookUser:nil];
        }
        // broadcast
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FINISH_LOGIN object:user];
        
        if (successBlock)
            successBlock(user);
        
        self.isLogging = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failureBlock)
            failureBlock(error.code, error);
        [[TMEFacebookManager sharedInstance] logout];
        self.isLogging = NO;
    }];
}

#pragma marks - Fake functions to handle users stuffs
- (TMEUser *)userWithDictionary:(NSDictionary *)dicData
{
    TMEUser *user;
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
                                 userID:(NSNumber *)userID
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:facebookToken forKey:LAST_LOGIN_FACEBOOK_TOKEN];
    [defaults setObject:accessToken forKey:LAST_LOGIN_ACCESS_TOKEN];
    [defaults setObject:userID forKey:LAST_LOGIN_USER_ID];
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

- (NSNumber *)getUserIDFromStore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSNumber *userID = [defaults objectForKey:LAST_LOGIN_USER_ID];
    return userID;
}

@end
