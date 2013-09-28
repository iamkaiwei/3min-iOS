//
//  TMEBrowerProductsTableCell.h
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import <UIKit/UIKit.h>

@interface TMEBrowserProductsTableCell : TMEBaseTableViewCell

- (void)configCellWithProduct:(TMEProduct *)product;
+ (CGFloat)getHeight;

@end
