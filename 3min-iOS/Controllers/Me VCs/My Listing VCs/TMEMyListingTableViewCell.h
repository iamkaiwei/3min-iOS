//
//  TMEMyListingTableViewCell.h
//  PhotoButton
//
//  Created by Toan Slan on 2/12/14.
//
//

#import "TMEBaseTableViewCell.h"

@interface TMEMyListingTableViewCell : TMEBaseTableViewCell

- (void)configCellWithData:(TMEProduct *)product;
+ (CGFloat)getHeight;

@end
