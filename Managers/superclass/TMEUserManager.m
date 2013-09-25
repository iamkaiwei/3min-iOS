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

- (void)setLoggedUser:(id<FBGraphUser>)loggedUser
{
    _loggedUser = loggedUser;
}

- (void)logOut
{
    self.loggedUser = nil;
}

- (NSString *)getAccessToken
{
#warning MUST HANDLE LATER
    return [[[FBSession activeSession] accessTokenData] accessToken];
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
