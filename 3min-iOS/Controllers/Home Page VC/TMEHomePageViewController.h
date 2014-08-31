//
//  TMEHomePageViewController.h
//  ThreeMin
//
//  Created by Triệu Khang on 4/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMEHomePageViewDatasource.h"
#import "TMEHomeNavigationViewController.h"

@interface TMEHomePageViewController : UIViewController

@property (nonatomic, strong, readonly) TMEHomeNavigationViewController *navVC;

@end
