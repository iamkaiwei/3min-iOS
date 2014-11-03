//
//  TMETopProfileCollectionViewCell.h
//  ThreeMin
//
//  Created by Triệu Khang on 29/10/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMETopProfileCollectionViewCellProtocol <NSObject>

- (void)onTapEdit;
- (void)onTapMyLikes;
- (void)onTapMyItems;
- (void)onTapPositive;
- (void)onTapFollowers;
- (void)onTapFollwings;

@end

@interface TMETopProfileCollectionViewCell : UICollectionViewCell
<
    KHCellProtocol
>

@property (nonatomic, weak) id<TMETopProfileCollectionViewCellProtocol> delegate;

@end
