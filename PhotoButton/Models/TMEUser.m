#import "TMEUser.h"


@interface TMEUser ()

// Private interface goes here.

@end


@implementation TMEUser

// Custom logic goes here.

+ (TMEUser *)userWithData:(id)data{
    TMEUser *user = [[TMEUser MR_findByAttribute:@"id" withValue:data[@"id"]] lastObject];
    if (!user) {
        user = [TMEUser MR_createEntity];
        user.id = data[@"id"];
        user.facebook_id = data[@"facebook_id"];
        user.udid = data[@"udid"];
    }
    
    if (data[@"facebook_avatar"] && ![data[@"facebook_avatar"] isEqual:[NSNull null]]){
        user.photo_url = data[@"facebook_avatar"];
    }
    user.username = data[@"username"];
    user.email = data[@"email"];
    user.fullname = data[@"full_name"];
    user.name = data[@"full_name"];
    
    return user;
}

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
        user.udid = userData[@"udid"];
        user.fullname = userData[@"full_name"];
        
        if (userData[@"facebook_avatar"] && ![userData[@"facebook_avatar"] isEqual:[NSNull null]]) {
            user.photo_url = userData[@"facebook_avatar"];
        }
    }
    
    return user;
}

@end
