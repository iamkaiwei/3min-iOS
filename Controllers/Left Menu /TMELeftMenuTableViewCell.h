//
//  TMELeftMenuTableViewCell.h
//  PhotoButton
//
//  Created by Triệu Khang on 27/10/13.
//
//

#import <UIKit/UIKit.h>

@interface TMELeftMenuTableViewCell : TMEBaseTableViewCell

+ (CGFloat )getHeight;
- (void)configCategoryCellWithCategory:(TMECategory *)category;

@end
