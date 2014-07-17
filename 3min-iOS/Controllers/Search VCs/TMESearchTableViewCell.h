//
//  TMESearchTableViewCell.h
//  PhotoButton
//
//  Created by Toan Slan on 2/24/14.
//
//

#import "TMEBaseTableViewCell.h"

@interface TMESearchTableViewCell : TMEBaseTableViewCell

- (void)configCellWithData:(TMEProduct *)product;
+ (CGFloat)getHeight;

@end
