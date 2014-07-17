//
//  TMEUser+BackwardSupport.h
//  ThreeMin
//
//  Created by iSlan on 7/17/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEUser.h"

@interface TMEUser (BackwardSupport)

+ (TMEUser *)userWithData:(id)data;
+ (TMEUser *)userByFacebookDictionary:(NSDictionary *)data;
+ (TMEUser *)userWithID:(NSNumber *)ID fullName:(NSString *)fullName photoURL:(NSString *)photoURL;

@end
