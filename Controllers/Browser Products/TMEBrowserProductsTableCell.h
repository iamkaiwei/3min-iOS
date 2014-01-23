//
//  TMEBrowerProductsTableCell.h
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import <UIKit/UIKit.h>

@protocol TMEBrowserProductsTableCellDelegate <NSObject>

- (void)onClickCategoryButton:(NSInteger)categoryID;

@optional
- (void)onBtnLike;
- (void)onBtnShare;

@end

@interface TMEBrowserProductsTableCell : TMEBaseTableViewCell

@property (assign, nonatomic) id<TMEBrowserProductsTableCellDelegate> delegate;

- (void)configCellWithProduct:(TMEProduct *)product;
+ (CGFloat)getHeight;

@end
