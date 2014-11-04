//
//  TMEBrowserProductCellFactory.h
//  ThreeMin
//
//  Created by Triệu Khang on 4/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KHTableViewController/KHSuperCollectionCellFactory.h>
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>
#import "TMEProductCollectionViewCell.h"

@interface TMEBrowserProductCellFactory : KHSuperCollectionCellFactory
<
KHCollectionViewCellFactoryProtocol
>

- (CHTCollectionViewWaterfallLayout *)waterFlowLayout;

@end
