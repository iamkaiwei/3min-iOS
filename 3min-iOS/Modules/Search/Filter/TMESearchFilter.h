//
//  TMESearchFilter.h
//  ThreeMin
//
//  Created by Khoa Pham on 8/29/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TMESearchFilterCriteria) {
    TMESearchFilterCriteriaPopular,
    TMESearchFilterCriteriaRecent,
    TMESearchFilterCriteriaLowestPrice,
    TMESearchFilterCriteriaHighestPrice,
    TMESearchFilterCriteriaNearest,
};

@interface TMESearchFilter : NSObject

@property (nonatomic, strong) NSNumber *minPrice;
@property (nonatomic, strong) NSNumber *maxPrice;
@property (nonatomic, assign) TMESearchFilterCriteria criteria;

+ (instancetype)defaultFilter;

@end
