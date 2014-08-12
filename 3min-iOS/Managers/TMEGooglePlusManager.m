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
}

- (void)signIn
{
    [[GPPSignIn sharedInstance] authenticate];
}

- (void)signOut
{
    [[GPPSignIn sharedInstance] signOut];
}

#pragma mark - GPPSignInDelegate
- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error
{

}

- (void)didDisconnectWithError:(NSError *)error
{
    DDLogVerbose(@"didDisconnectWithError %@", error);
}

@end
