//
//  TMEUserItemsViewController.h
//  ThreeMin
//
//  Created by Vinh Nguyen on 22/12/2014.
//  Copyright (c) Năm 2014 3min. All rights reserved.
//

#import <KHTableViewController/KHBasicOrderedCollectionViewController.h>

@interface TMEUserItemsViewController : KHBasicOrderedCollectionViewController
@property (nonatomic, strong) TMEUser *user;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end
