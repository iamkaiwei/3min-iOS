//
//  TMELoadMoreTableViewCell.m
//  PhotoButton
//
//  Created by Toan Slan on 1/9/14.
//
//

#import "TMELoadMoreTableViewCell.h"

@interface TMELoadMoreTableViewCell()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@end

@implementation TMELoadMoreTableViewCell

- (void)startLoading{
  [self.loadingIndicator startAnimating];
}

+ (NSString *)getIdentifier{
  return NSStringFromClass([TMELoadMoreTableViewCell class]);
}

+ (CGFloat)getHeight{
  return 44;
}

@end
