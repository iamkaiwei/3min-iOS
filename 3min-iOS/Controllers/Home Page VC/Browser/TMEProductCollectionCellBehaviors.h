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
 *  @param onViewController <#onViewController description#>
 *  @param product          <#product description#>
 *  @param action           <#action description#>
 */

void ProductCollectionCellAct(UIViewController *onViewController, TMEProduct *product, TMEProductCollectionCellAction action);
