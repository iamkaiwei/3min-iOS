//
//  TMEProductCollectionViewCell.h
//  ThreeMin
//
//  Created by Triệu Khang on 9/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMEProductCollectionViewCell;

@protocol TMEProductCollectionViewCellDelegate <NSObject>

@optional
- (void)tapOnLikeProductOnCell:(TMEProductCollectionViewCell *)cell;
- (void)tapOnShareProductOnCell:(TMEProductCollectionViewCell *)cell;
- (void)tapOnCommentProductOnCell:(TMEProductCollectionViewCell *)cell;
- (void)tapOnDetailsProductOnCell:(TMEProductCollectionViewCell *)cell;
- (void)tapOnViewProfileOnProductOnCell:(TMEProductCollectionViewCell *)cell;

@end

@interface TMEProductCollectionViewCell : UICollectionViewCell
<
KHCellProtocol
>

@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) id<TMEProductCollectionViewCellDelegate> delegate;

- (void)configWithData:(TMEProduct *)product;
- (void)loadImages:(TMEProduct *)product;

@end
