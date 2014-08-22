//
//  TMEProductCollectionViewCell.h
//  ThreeMin
//
//  Created by Triệu Khang on 9/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMEProductCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblProductName;

- (void)configWithData:(TMEProduct *)product;

@end
