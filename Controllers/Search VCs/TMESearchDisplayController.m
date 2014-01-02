//
//  TMESearchDisplayController.m
//  PhotoButton
//
//  Created by admin on 1/2/14.
//
//

#import "TMESearchDisplayController.h"

@implementation TMESearchDisplayController

- (void)setActive:(BOOL)visible animated:(BOOL)animated{
  [super setActive:visible animated:animated];
  [self.searchContentsController.navigationController setNavigationBarHidden:NO animated:NO];
}

@end
