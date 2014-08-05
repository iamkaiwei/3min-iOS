//
//  TMEActivity.h
//  ThreeMin
//
//  Created by Khoa Pham on 8/5/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "MTLModel.h"

@class TMEUser;

@interface TMEActivity : TMEBaseModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *activityId;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *subjectId;
@property (nonatomic, copy) NSString *subjectType;
@property (nonatomic, strong) NSNumber *updateTime;
@property (nonatomic, strong) TMEUser *user;

@end
