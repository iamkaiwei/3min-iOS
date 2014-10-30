//
//  TMECategory.h
//  ThreeMin
//
//  Created by Khoa Pham on 8/5/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "MTLModel.h"

@class TMEImage;

@interface TMECategory : TMEBaseModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *categoryId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *categoryDescription;
@property (nonatomic, copy) NSString *specificType;

@property (nonatomic, strong) TMEImage *image;

@end
