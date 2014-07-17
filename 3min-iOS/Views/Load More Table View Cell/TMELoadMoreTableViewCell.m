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
  self.labelLoading.text = NSLocalizedString(@"Loading...", nil);
}

+ (CGFloat)getHeight{
  return 44;
}

@end
