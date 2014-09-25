//
//  TMEActivitiesCollectionViewCell.h
//  ThreeMin
//
//  Created by Triệu Khang on 24/9/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMEActivitiesCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgViewClock;
@property (copy, nonatomic, readonly) void (^configBlock)(UICollectionViewCell *cell, TMEActivity *activity);

- (void)configWithData:(TMEActivity *)activity;

@end
