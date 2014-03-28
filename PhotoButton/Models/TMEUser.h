#import "_TMEUser.h"

@interface TMEUser : _TMEUser {}
// Custom logic goes here.
+ (TMEUser *)userWithData:(id)data;
+ (TMEUser *)userByFacebookUser:(id<FBGraphUser>)facebookUser;
+ (TMEUser *)userByFacebookDictionary:(NSDictionary *)data;
+ (TMEUser *)userWithID:(NSNumber *)ID fullName:(NSString *)fullName avatarURL:(NSString *)avatarURL;

@end
