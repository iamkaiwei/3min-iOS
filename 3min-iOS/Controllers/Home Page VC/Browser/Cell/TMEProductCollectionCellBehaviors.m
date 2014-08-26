//
//  TMEProductCollectionCellBehaviors.m
//  ThreeMin
//
//  Created by Triệu Khang on 23/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductCollectionCellBehaviors.h"

void ProductCollectionCellLike(UIViewController *onViewController, TMEProduct *product) {
    NSLog(@"Like");

}
void ProductCollectionCellComment(UIViewController *onViewController, TMEProduct *product) {
    NSLog(@"Comment");
}
void ProductCollectionCellShare(UIViewController *onViewController, TMEProduct *product) {
    NSLog(@"Share");
}

void ProductCollectionCellGoDetails(UIViewController *onViewController, TMEProduct *product) {
    NSLog(@"Details");
}

void ProductCollectionCellAct(UIViewController *onViewController, TMEProduct *product, TMEProductCollectionCellAction action) {
    switch (action) {
        case TMEProductCollectionCellGoDetails:
            ProductCollectionCellGoDetails(onViewController, product);
            break;

        case TMEProductCollectionCellLike:
            ProductCollectionCellLike(onViewController, product);
            break;

        case TMEProductCollectionCellShare:
            ProductCollectionCellShare(onViewController, product);
            break;

        case TMEProductCollectionCellComment:
            ProductCollectionCellComment(onViewController, product);
            break;

        case TMEProductCollectionCellUnknown:
        default:
            break;
    }
}
