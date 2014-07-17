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

        //FIXME: facebook_id is NULL
        if ([data[@"facebook_id"] isMemberOfClass:[NSString class]]) {
            user.facebook_id = data[@"facebook_id"];
        }

        if (data[@"udid"] && ![data[@"udid"] isEqual:[NSNull null]]) {
            user.udid = data[@"udid"];
        }
    }
    
    if (data[@"facebook_avatar"] && ![data[@"facebook_avatar"] isEqual:[NSNull null]]){
        user.photo_url = data[@"facebook_avatar"];
    }

    // FIXME: username is NULL
    if ([data[@"username"] isMemberOfClass:[NSString class]]) {
        user.username = data[@"username"];
    }

    user.email = data[@"email"];
    user.fullname = data[@"full_name"];
    user.name = data[@"full_name"];
    
    return user;
}


- (BOOL)userFromDictionary:(NSDictionary *)dict {
    BOOL result = [KZPropertyMapper mapValuesFrom:dict
                         toInstance:self
                       usingMapping:@{
                                      @"id": KZProperty(id),
                                      @"full_name": KZProperty(fullname),
                                      @"facebook_id": KZProperty(facebook_id),
                                      @"facebook_avatar": KZProperty(photo_url),
                                      @"email": KZProperty(email),
                                      @"username": KZProperty(username),
                                      @"udid": KZProperty(udid)
                                      }];
    return result;
}

+ (TMEUser *)userByFacebookUser:(id<FBGraphUser>)facebookUser{
    TMEUser *user = [[TMEUser MR_findByAttribute:@"facebook_id" withValue:facebookUser.id] lastObject];
    if (!user) {
        user = [TMEUser MR_createEntity];
        user.facebook_id = facebookUser.id;
    }
    user.name = facebookUser.name;
    user.username = facebookUser.username;
    return user;
}

+ (TMEUser *)userByFacebookDictionary:(NSDictionary *)data{
    if (data[@"user"]) {
        NSDictionary *userData = data[@"user"];
        TMEUser *user = [[TMEUser MR_findByAttribute:@"id" withValue:userData[@"id"]] lastObject];
        if (!user) {
            user = [TMEUser MR_createEntity];
            user.facebook_id = userData[@"facebook_id"];
            user.id = userData[@"id"];
            if (data[@"udid"] && ![data[@"udid"] isEqual:[NSNull null]]) {
                user.udid = userData[@"udid"];
            }
        }
        user.name = userData[@"full_name"];

        // FIXME: username is NULL
        if ([userData[@"username"] isMemberOfClass:[NSString class]]) {
            user.username = userData[@"username"];
        }

        if (userData[@"email"] && ![userData[@"email"] isEqual:[NSNull null]]) {
            user.email = userData[@"email"];
        }
        user.access_token = data[@"access_token"];
        user.fullname = userData[@"full_name"];
        
        if (userData[@"facebook_avatar"] && ![userData[@"facebook_avatar"] isEqual:[NSNull null]]) {
            user.photo_url = userData[@"facebook_avatar"];
        }
        return user;
    }
    return nil;
}

+ (TMEUser *)userWithID:(NSNumber *)ID fullName:(NSString *)fullName avatarURL:(NSString *)avatarURL
{
    TMEUser *user = [[TMEUser MR_findByAttribute:@"id" withValue:ID] lastObject];
    if (!user) {
        user = [TMEUser MR_createEntity];
        user.id = ID;
    }

    user.name = fullName;
    user.photo_url = avatarURL;

    return user;
}

@end
