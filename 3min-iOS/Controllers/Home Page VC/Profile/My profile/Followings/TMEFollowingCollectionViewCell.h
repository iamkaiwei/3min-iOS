//
//  TMEFollowingCollectionViewCell.h
//  ThreeMin
//
//  Created by Triệu Khang on 1/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMEFollowingCollectionViewCellProtocol <NSObject>

- (void)onFollowButton:(id)sender;

@end

@interface TMEFollowingCollectionViewCell : UICollectionViewCell
<
KHCellProtocol
>

@property (nonatomic, weak) id<TMEFollowingCollectionViewCellProtocol> delegate;

@end
