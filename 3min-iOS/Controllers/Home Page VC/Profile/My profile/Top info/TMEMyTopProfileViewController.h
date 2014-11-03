//
//  TMEViewController.h
//  ThreeMin
//
//  Created by Triệu Khang on 22/9/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMETopProfileCollectionViewCell.h"

@interface TMEMyTopProfileViewController : UIViewController
<
    TMETopProfileCollectionViewCellProtocol
>

@property (strong, nonatomic) TMEUser *user;

@end
