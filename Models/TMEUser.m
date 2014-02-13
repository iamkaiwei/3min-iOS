#import "TMEUser.h"


@interface TMEUser ()

// Private interface goes here.

@end


@implementation TMEUser

// Custom logic goes here.

+ (TMEUser *)userWithData:(id)data{
  TMEUser *user = [[TMEUser MR_findByAttribute:@"name" withValue:data[@"full_name"]] lastObject];
  if (!user) {
    user = [TMEUser MR_createEntity];
    user.id = data[@"id"];
    user.email = data[@"email"];
    user.facebook_id = data[@"facebook_id"];
    user.fullname = data[@"full_name"];
    user.name = data[@"full_name"];
    user.username = data[@"username"];
    user.udid = data[@"udid"];
    if (data[@"facebook_avatar"] && ![data[@"facebook_avatar"] isEqual:[NSNull null]])
      user.photo_url = data[@"facebook_avatar"];
  }
  return user;
}

@end
