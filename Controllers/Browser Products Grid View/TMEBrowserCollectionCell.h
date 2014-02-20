//
//  TMEBrowserCollectionCell.h
//  PhotoButton
//
//  Created by Triệu Khang on 13/10/13.
//
//

#import <UIKit/UIKit.h>

@interface TMEBrowserCollectionCell : UICollectionViewCell

- (void)configCellWithData:(TMEProduct *)product;
- (void)didSelectCellAnimation;
- (void)didDeselectCellAnimation;
+ (CGSize)productCellSize;

@end
