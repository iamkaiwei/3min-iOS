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
    self.loggedUser = [NSKeyedUnarchiver unarchiveObjectWithData:archived];

    [self validateAccessTokenExpiration];
}

- (void)validateAccessTokenExpiration
{
    // If access token expires, set user to nil
}




@end
