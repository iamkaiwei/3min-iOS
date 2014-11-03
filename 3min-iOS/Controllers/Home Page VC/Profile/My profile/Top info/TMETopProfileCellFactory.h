//
//  TMETopProfileCellFactory.h
//  ThreeMin
//
//  Created by Triệu Khang on 29/10/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHSuperCollectionCellFactory.h"

@interface TMETopProfileCellFactory : KHSuperCollectionCellFactory
<
KHCollectionViewCellFactoryProtocol
>

@property (nonatomic, weak) id delegate;

@end
