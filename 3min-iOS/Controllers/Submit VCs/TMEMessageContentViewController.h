//
//  TMEMessageContentViewController.h
//  ThreeMin
//
//  Created by iSlan on 11/7/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMEUserMessageParameter.h"

@interface TMEMessageContentViewController : KHBasicOrderedCollectionViewController
<KHBasicOrderedCollectionViewControllerProtocol>

@property (strong, nonatomic) TMEUserMessageParameter *parameter;

@end
