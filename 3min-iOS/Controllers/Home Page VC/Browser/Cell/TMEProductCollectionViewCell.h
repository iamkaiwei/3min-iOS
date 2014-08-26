//
//  TMEProductCollectionViewCell.h
//  ThreeMin
//
//  Created by Triệu Khang on 9/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMEProductCollectionViewCell;

@protocol TMEProductCollectionViewCellDelete <NSObject>

- (void)tapOnLikeProductOnCell:(TMEProductCollectionViewCell *)cell;
- (void)tapOnShareProductOnCell:(TMEProductCollectionViewCell *)cell;
- (void)tapOnCommentProductOnCell:(TMEProductCollectionViewCell *)cell;
- (void)tapOnDetailsProductOnCell:(TMEProductCollectionViewCell *)cell;

@end

@interface TMEProductCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) id<TMEProductCollectionViewCellDelete> delegate;

- (void)configWithData:(TMEProduct *)product;

@end
