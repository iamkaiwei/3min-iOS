//
//  TMEProductCommentsVC.h
//  ThreeMin
//
//  Created by Khoa Pham on 9/22/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMEProduct;

@interface TMEProductCommentsVC : UIViewController

@property (nonatomic, strong) TMEProduct *product;
@property (nonatomic, assign) BOOL displayedAsChild;

@end
