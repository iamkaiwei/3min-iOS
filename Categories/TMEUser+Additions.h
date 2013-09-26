//
//  TMEUser+Additions.h
//  PhotoButton
//
//  Created by Triệu Khang on 25/9/13.
//
//

#import "TMEUser.h"

@interface TMEUser (Additions)

+ (TMEUser *)userByFacebookUser:(id<FBGraphUser>)facebookUser;
+ (TMEUser *)userByFacebookDictionary:(NSDictionary *)data;

@end
