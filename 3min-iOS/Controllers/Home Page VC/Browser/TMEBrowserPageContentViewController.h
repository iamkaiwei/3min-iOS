//
//  TMEBrowserPageContentViewController.h
//  ThreeMin
//
//  Created by Triệu Khang on 4/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KHTableViewController/KHBasicOrderedCollectionViewController.h>

@interface TMEBrowserPageContentViewController : KHBasicOrderedCollectionViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) TMECategory *currentCategory;

@end
