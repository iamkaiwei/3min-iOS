//
//  TMEFollowingCellFactory.h
//  ThreeMin
//
//  Created by Triệu Khang on 1/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KHTableViewController/KHSuperCollectionCellFactory.h>
#import "TMEFollowingCollectionViewCell.h"

@interface TMEFollowingCellFactory : KHSuperCollectionCellFactory
<
KHCollectionViewCellFactoryProtocol
>

@property (nonatomic, weak) id<TMEFollowingCollectionViewCellProtocol> cellDelegate;

@end
