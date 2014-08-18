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
@property (nonatomic, strong) NSNumber *expiresIn;
@property (nonatomic, copy) NSString *tokenType;

@property (nonatomic, strong) NSNumber *facebookID;
@property (nonatomic, copy) NSString *facebookAvatar;
@property (nonatomic, strong) NSNumber *googleID;


@property (nonatomic, strong) NSNumber *userID;
@property (nonatomic, copy) NSString *userUDID;
@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, strong) NSDate *birthday;
@property (nonatomic, copy) NSString *email;


@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *middleName;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *role;

// Useful properties
@property (nonatomic, strong) NSDate *accessTokenReceivedAt;

@end
