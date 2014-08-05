//
//  TMEUser.h
//  ThreeMin
//
//  Created by iSlan on 7/17/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "MTLModel.h"

@interface TMEUser : TMEBaseModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *facebookID;
@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, strong) NSNumber *userID;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSURL *photoURL;
@property (nonatomic, copy) NSString *UDID;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, strong) NSDate *birthday;
@property (nonatomic, copy) NSString *googleID;

@property (nonatomic, strong) NSArray *activities;
@property (nonatomic, strong) NSArray *products;

@end
