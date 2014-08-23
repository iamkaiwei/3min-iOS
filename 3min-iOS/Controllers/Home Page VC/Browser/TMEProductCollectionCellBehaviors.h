//
//  TMEProductCollectionCellBehaviors.h
//  ThreeMin
//
//  Created by Triệu Khang on 23/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

typedef NS_ENUM(NSUInteger, TMEProductCollectionCellAction) {
    TMEProductCollectionCellGoDetails,
    TMEProductCollectionCellLike,
    TMEProductCollectionCellComment,
    TMEProductCollectionCellShare,
    TMEProductCollectionCellUnknown,
};

/**
 *  Handle behaviour of product collection view cell
 *
 *  @param onViewController which view controller the cell in on
 *  @param product          which product invoke
 *  @param action           what the action, TMEProductCollectionCellAction type
 */

void ProductCollectionCellAct(UIViewController *onViewController, TMEProduct *product, TMEProductCollectionCellAction action);
