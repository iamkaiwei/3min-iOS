//
//  TMEConversation.h
//  ThreeMin
//
//  Created by Triệu Khang on 20/7/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "MTLModel.h"

@interface TMEConversation : TMEBaseModel <MTLJSONSerializing>

@property (nonatomic, copy  ) NSString   *channelName;
@property (nonatomic, strong) NSNumber   *id;
@property (nonatomic, copy  ) NSString   *latestMessage;
@property (nonatomic, strong) NSDate     *latestUpdate;
@property (nonatomic, strong) NSNumber   *offer;
@property (nonatomic, copy  ) NSString   *userAvatar;
@property (nonatomic, copy  ) NSString   *userFullname;
@property (nonatomic, strong) NSNumber   *userID;

@property (nonatomic, strong) NSArray    *replies;
@property (nonatomic, weak  ) TMEProduct *product;

@end
