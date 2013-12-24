//
//  TMEUser+Additions.m
//  PhotoButton
//
//  Created by Triệu Khang on 25/9/13.
//
//

#import "TMEUser+Additions.h"

@implementation TMEUser (Additions)

+ (TMEUser *)userByFacebookUser:(id<FBGraphUser>)facebookUser{
    TMEUser *user = [[TMEUser alloc] init];
    user.name = facebookUser.name;
    user.facebook_id = facebookUser.id;
    user.username = facebookUser.username;
    
    return user;
}

+ (TMEUser *)userByFacebookDictionary:(NSDictionary *)data{
    TMEUser *user = [TMEUser MR_createEntity];
    
    if (data[@"user"]) {
        NSDictionary *userData = data[@"user"];
        
        user.name = userData[@"full_name"];
        user.facebook_id = userData[@"facebook_id"];
        user.id = userData[@"id"];
        user.username = userData[@"username"];
        user.email = userData[@"email"];
        user.access_token = data[@"access_token"];
        user.udid = data[@"udid"];
        user.fullname = data[@"full_name"];
        
        if (userData[@"facebook_avatar"] && ![userData[@"facebook_avatar"] isEqual:[NSNull null]]) {
            user.photo_url = userData[@"facebook_avatar"];
        }
    }

    return user;
}

@end
