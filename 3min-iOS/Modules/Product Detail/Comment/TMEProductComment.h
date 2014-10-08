//
//  TMEProductComment.h
//  ThreeMin
//
//  Created by Khoa Pham on 10/6/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEBaseModel.h"

@class TMEUser;

@interface TMEProductComment : TMEBaseModel

@property (nonatomic, strong) NSNumber *commentID;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) TMEUser *user;

@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;

@end
