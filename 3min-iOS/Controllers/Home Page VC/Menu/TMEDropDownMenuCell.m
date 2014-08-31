//
//  TMEDropDownMenuCell.m
//  ThreeMin
//
//  Created by Triệu Khang on 28/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEDropDownMenuCell.h"

@interface TMEDropDownMenuCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblCategoryName;

@end

@implementation TMEDropDownMenuCell

- (void)configWithCategory:(TMECategory *)category {
    self.lblCategoryName.text = category.name;
    [self.imageViewCategory sd_setImageWithURL:[NSURL URLWithString:[category.image urlString]]];
}

@end
