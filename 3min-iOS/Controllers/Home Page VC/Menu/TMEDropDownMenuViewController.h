//
//  TMEDropDownMenuViewController.h
//  ThreeMin
//
//  Created by Triệu Khang on 28/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMEHomeNavigationButtonDelegate.h"

@protocol TMEHomeNavigationButtonProtocol;

@interface TMEDropDownMenuViewController : UIViewController
<
    UICollectionViewDelegate,
    UIGestureRecognizerDelegate
>

@property (nonatomic, strong, readonly) TMECategory *selectedCategory;
@property (nonatomic, assign) id<TMEHomeNavigationButtonProtocol> delegate;

@end
