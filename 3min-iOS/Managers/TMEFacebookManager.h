//
//  TMEFacebookManager.h
//  PhotoButton
//
//  Created by Triệu Khang on 26/10/13.
//
//

typedef void (^TMEFacebookManagerSuccessBlock)(NSString *facebookToken);

@interface TMEFacebookManager : TMEBaseManager

OMNIA_SINGLETON_H(sharedManager)

- (void)setup;
- (void)signInWithSuccess:(TMEFacebookManagerSuccessBlock)success
                  failure:(TMEFailureBlock)failure;

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState)state error:(NSError *)error;
- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication;
- (void)handleDidBecomeActive;

@end
