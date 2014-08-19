//
//  TMEGooglePlusManager.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/12/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEGooglePlusManager.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>

static NSString *const clientID = @"349583123438-pjv0gppnups9vi6qjet02tdl19qhcrn0.apps.googleusercontent.com";

@interface TMEGooglePlusManager () <GPPSignInDelegate>

@property (nonatomic, copy) TMEGooglePlusManagerSuccessBlock succcessBlock;
@property (nonatomic, copy) TMEFailureBlock failureBlock;

@end

@implementation TMEGooglePlusManager

OMNIA_SINGLETON_M(sharedManager)

- (void)setup
{
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;
    signIn.clientID = clientID;
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];

    signIn.delegate = self;

    [signIn trySilentAuthentication];

    [self registerNotifications];
}

- (void)signIn
{
    [[GPPSignIn sharedInstance] authenticate];
}

- (void)signOut
{
    [[GPPSignIn sharedInstance] signOut];
}

#pragma mark - Public Interface
- (void)signInWithSuccess:(TMEGooglePlusManagerSuccessBlock)success
                  failure:(TMEFailureBlock)failure
{
    self.succcessBlock = success;
    self.failureBlock = failure;

    [self signIn];
}

#pragma mark - GPPSignInDelegate
- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error
{
    if (error) {
        if (self.failureBlock) {
            self.failureBlock(error);
            self.failureBlock = nil;
        }
    } else {
        if (self.succcessBlock) {
            self.succcessBlock(auth.accessToken);
            self.succcessBlock = nil;
        }
    }
}

- (void)didDisconnectWithError:(NSError *)error
{
    DDLogVerbose(@"didDisconnectWithError %@", error);
}

- (void)registerNotifications
{
    [self tme_registerNotifications:@{TMEUserDidLogoutNotification:
                                          NSStringFromSelector(@selector(handleUserDidLogoutNotification:)),
                                      }];
}

- (void)handleUserDidLogoutNotification:(NSNotification *)note
{
    [[GPPSignIn sharedInstance] signOut];
}


@end
