//
//  TMEProductCollectionViewCell+Template.h
//  ThreeMin
//
//  Created by Triệu Khang on 22/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductCollectionViewCell.h"

@interface TMEProductCollectionViewCell (Template)

+ (instancetype)sharedTemplate;

- (CGFloat)staticBottomInformationHeightWithProduct:(TMEProduct *)product;

@end
