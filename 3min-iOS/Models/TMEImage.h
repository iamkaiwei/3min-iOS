//
//  TMEImage.h
//  ThreeMin
//
//  Created by Khoa Pham on 8/5/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "MTLModel.h"

@interface TMEImage : TMEBaseModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *imageId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *urlString;

@end
