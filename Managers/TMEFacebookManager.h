//
//  TMEFacebookManager.h
//  PhotoButton
//
//  Created by Triệu Khang on 26/10/13.
//
//

#import "BaseManager.h"
#import "FacebookManager.h"

@interface TMEFacebookManager : FacebookManager

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user;
- (void)showLoginView;

@end
