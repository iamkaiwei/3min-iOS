//
//  TMESearchFilterOnlyTableVC.h
//  ThreeMin
//
//  Created by Khoa Pham on 9/1/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMESearchFilter;

@interface TMESearchFilterOnlyTableVC : UITableViewController

@property (nonatomic, strong) TMESearchFilter *searchFilter;

- (void)resetFilter;

@end
