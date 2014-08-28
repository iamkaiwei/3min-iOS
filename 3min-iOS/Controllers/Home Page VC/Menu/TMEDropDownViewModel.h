//
//  TMEDropDownViewModel.h
//  ThreeMin
//
//  Created by Triệu Khang on 28/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMEDropDownViewModel : NSObject

- (void)getCategories:(void(^)(NSArray* category, NSError *error))block;

@end
