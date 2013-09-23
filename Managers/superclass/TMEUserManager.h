//
//  TMEUserManager.h
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "BaseManager.h"

@interface TMEUserManager : BaseManager

@property (assign, nonatomic) id<FBGraphUser>           loggedUser;

- (NSString *)getAccessToken;

- (void)setLoggedUser:(id<FBGraphUser>)loggedUser;
- (void)logOut;
- (BOOL)isLoggedUser;

@end
