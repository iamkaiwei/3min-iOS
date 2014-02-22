//
//  TMELikedTableViewCell.h
//  PhotoButton
//
//  Created by Toan Slan on 2/17/14.
//
//

#import "TMEBaseTableViewCell.h"

@interface TMELikedTableViewCell : TMEBaseTableViewCell

- (void)configCellWithData:(TMEProduct *)product;
+ (CGFloat)getHeight;

@end
