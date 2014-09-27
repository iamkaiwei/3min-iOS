//
//  TMEActivitiesCollectionViewCell.h
//  ThreeMin
//
//  Created by Triệu Khang on 24/9/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMEActivitiesCollectionViewCell : UICollectionViewCell

- (void)configWithData:(TMEActivity *)activity;
- (CGFloat)heightForActivity:(TMEActivity *)activity;

@end
