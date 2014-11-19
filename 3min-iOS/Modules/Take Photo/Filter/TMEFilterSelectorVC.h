//
//  TMEFilterSelectorVC.h
//  ThreeMin
//
//  Created by Khoa Pham on 11/19/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMEFilterSelectorVCDelegate <NSObject>

- (void)filterSelectorVCDidSelectFilter;

@end

@interface TMEFilterSelectorVC : UICollectionViewController

@property (nonatomic, weak) id<TMEFilterSelectorVCDelegate> delegate;

@end
