//
//  TMEBaseModel+TMEAdditions.h
//  ThreeMin
//
//  Created by Khoa Pham on 8/5/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEBaseModel.h"

@interface TMEBaseModel (TMEAdditions)

+ (NSArray *)tme_modelsFromJSONResponse:(id)JSONResponse;
+ (instancetype)tme_modelFromJSONResponse:(id)JSONResponse;

@end
