//
//  TMESearchTextViewController.h
//  ThreeMin
//
//  Created by Khoa Pham on 8/29/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMESearchTextViewController;

@protocol TMESearchTextViewController <NSObject>

- (void)searchTextVC:(TMESearchTextViewController *)searchTextVC didSelectText:(NSString *)text;
- (void)searchTextVCDidCancel:(TMESearchTextViewController *)searchTextVC;

@end

@interface TMESearchTextViewController : UIViewController

@property (nonatomic, weak) id<TMESearchTextViewController> delegate;

@end
