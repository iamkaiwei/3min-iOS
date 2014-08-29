//
//  TMEDropDownMenuViewController.h
//  ThreeMin
//
//  Created by Triệu Khang on 28/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMEHomeNavigationButtonDelegate.h"

@interface TMEDropDownMenuViewController : UIViewController

@property (nonatomic, assign) id<TMEHomeNavigationButtonProtocol> delegate;

@end
