//
//  TMECameraFilterSelectorVC.h
//  ThreeMin
//
//  Created by Khoa Pham on 11/19/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMECameraFilterSelectorVCDelegate <NSObject>

- (void)filterSelectorVCDidSelectFilter;

@end

@interface TMECameraFilterSelectorVC : UICollectionViewController

@property (nonatomic, weak) id<TMECameraFilterSelectorVCDelegate> delegate;

@end
