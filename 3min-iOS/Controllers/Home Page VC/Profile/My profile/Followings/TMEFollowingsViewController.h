//
//  TMEFollowingsViewController.h
//  ThreeMin
//
//  Created by Triệu Khang on 1/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KHTableViewController/KHBasicOrderedCollectionViewController.h>

@interface TMEFollowingsViewController : KHBasicOrderedCollectionViewController

- (instancetype)initWithUser:(TMEUser *)user;

@end
