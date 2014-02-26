//
//  TMELoadMoreTableViewCell.m
//  PhotoButton
//
//  Created by Toan Slan on 1/9/14.
//
//

#import "TMELoadMoreTableViewCell.h"

@implementation TMELoadMoreTableViewCell

- (void)startLoading{
  [self.labelLoading startAnimating];
  self.labelLoading.text = @"Loading...";
}

+ (CGFloat)getHeight{
  return 44;
}

@end
