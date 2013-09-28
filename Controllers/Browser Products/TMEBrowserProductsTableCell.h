//
//  TMEBrowerProductsTableCell.h
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import <UIKit/UIKit.h>

@protocol TMEBrowserProductsTableCellDelegate <NSObject>

@required
- (void)onBtnLike;
- (void)onBtnComment;
- (void)onBtnShare;

@end

@interface TMEBrowserProductsTableCell : TMEBaseTableViewCell

@property (assign, nonatomic) id<TMEBrowserProductsTableCellDelegate> delegate;

- (void)configCellWithProduct:(TMEProduct *)product;
+ (CGFloat)getHeight;

@end
