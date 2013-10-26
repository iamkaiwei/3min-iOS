//
//  TMEFacebookManager.h
//  PhotoButton
//
//  Created by Triệu Khang on 26/10/13.
//
//

#import "BaseManager.h"

@interface TMEFacebookManager : BaseManager

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user;

@end
