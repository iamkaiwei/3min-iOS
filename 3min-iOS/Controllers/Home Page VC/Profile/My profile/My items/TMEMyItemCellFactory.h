//
//  TMEMyItemCellFactory.h
//  ThreeMin
//
//  Created by Triệu Khang on 6/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KHTableViewController/KHSuperCollectionCellFactory.h>
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>
#import "TMEProductCollectionViewCell.h"

@interface TMEMyItemCellFactory : KHSuperCollectionCellFactory
<
KHCollectionViewCellFactoryProtocol
>

@property (nonatomic, weak) id<TMEProductCollectionViewCellDelegate> delegate;

@end
