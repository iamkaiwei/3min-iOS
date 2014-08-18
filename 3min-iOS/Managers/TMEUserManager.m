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
    NSData *archived = [NSKeyedArchiver archivedDataWithRootObject:self.user];
    [[NSUserDefaults standardUserDefaults] setObject:archived forKey:kUserKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)load
{
    NSData *archived = [[NSUserDefaults standardUserDefaults] objectForKey:kUserKey];
    self.user = [NSKeyedUnarchiver unarchiveObjectWithData:archived];

    [self validateAccessTokenExpiration];
}

- (void)validateAccessTokenExpiration
{
    // If access token expires, set user to nil
}




@end
