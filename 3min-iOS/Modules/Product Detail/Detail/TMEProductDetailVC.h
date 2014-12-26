//
//  TMEProductDetailVC.h
//  ThreeMin
//
//  Created by Khoa Pham on 9/22/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMEBaseViewController.h"

@class TMEProduct;
@interface TMEProductDetailVC : TMEBaseViewController
@property (nonatomic, strong) TMEProduct *product;
@end
