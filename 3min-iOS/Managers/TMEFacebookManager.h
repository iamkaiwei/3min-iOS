//
//  TMEFacebookManager.h
//  PhotoButton
//
//  Created by Triệu Khang on 26/10/13.
//
//

#import "FacebookManager.h"

@interface TMEFacebookManager : FacebookManager

OMNIA_SINGLETON_H(sharedManager)

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user;
- (void)showLoginView;


@end
