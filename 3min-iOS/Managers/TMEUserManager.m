//
//  TMEUserManager.m
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "TMEUserManager.h"

static NSString *const kUserKey = @"kUserKey";

@interface TMEUserManager()

@end

@implementation TMEUserManager

OMNIA_SINGLETON_M(sharedManager)

- (void)save
{
    NSData *archived = [NSKeyedArchiver archivedDataWithRootObject:self.loggedUser];
    [[NSUserDefaults standardUserDefaults] setObject:archived forKey:kUserKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)load
{
    NSData *archived = [[NSUserDefaults standardUserDefaults] objectForKey:kUserKey];

    TMEUser *user = [NSKeyedUnarchiver unarchiveObjectWithData:archived];

    if ([self isAccessTokenValid:user]) {
        self.loggedUser = user;
    }
}

- (BOOL)isAccessTokenValid:(TMEUser *)user
{
    NSDate *accessTokenExpireDate = [user.accessTokenReceivedAt
                                     dateByAddingTimeInterval:user.expiresIn.doubleValue];

    return [accessTokenExpireDate compare:[NSDate date]] == NSOrderedDescending;
}




@end
