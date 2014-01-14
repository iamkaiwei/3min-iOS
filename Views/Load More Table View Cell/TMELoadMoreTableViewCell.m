//
//  TMELoadMoreTableViewCell.m
//  PhotoButton
//
//  Created by Toan Slan on 1/9/14.
//
//

#import "TMELoadMoreTableViewCell.h"

@interface TMELoadMoreTableViewCell()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorLoadMoreButton;

@end

@implementation TMELoadMoreTableViewCell

+ (CGFloat)getHeight{
  return 44;
}

- (IBAction)buttonLoadMoreAction:(id)sender {
  [self.buttonLoadMore setTitle:@"Loading..." forState:UIControlStateNormal];
  [self.activityIndicatorLoadMoreButton startAnimating];
  if ([self.delegate respondsToSelector:@selector(onBtnLoadMore:)]) {
    [self.delegate performSelector:@selector(onBtnLoadMore:) withObject:sender];
  }
}

@end
