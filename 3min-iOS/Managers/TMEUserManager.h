//
//  TMEUserManager.h
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

@class TMEUser;

typedef void (^TMEUserManagerSuccessBlock)(TMEUser *user);

@interface TMEUserManager : TMEBaseManager

OMNIA_SINGLETON_H(sharedManager)

@property (strong, nonatomic) TMEUser *loggedUser;

- (void)save;
- (void)load;

@end
