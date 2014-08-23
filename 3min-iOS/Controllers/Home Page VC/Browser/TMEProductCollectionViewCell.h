//
//  TMEProductCollectionViewCell.h
//  ThreeMin
//
//  Created by Triệu Khang on 9/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMEProductCollectionViewCellDelete <NSObject>

- (void)tapOnLikeProduct:(TMEProduct *)product atIndexPath:(NSIndexPath *)indexPath;
- (void)tapOnShareProduct:(TMEProduct *)product;
- (void)tapOnCommentProduct:(TMEProduct *)product;
- (void)tapOnDetailsProduct:(TMEProduct *)product;

@end

@interface TMEProductCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblProductName;

- (void)configWithData:(TMEProduct *)product;

@end
