//
//  TMEBrowserProductTableViewHeader.m
//  PhotoButton
//
//  Created by Toan Slan on 2/21/14.
//
//

#import "TMEBrowserProductTableViewHeader.h"

@implementation TMEBrowserProductTableViewHeader

- (void)configHeaderWithData:(TMEProduct *)product{
  [self.imgUserAvatar setImageWithURL:[NSURL URLWithString:product.user.photo_url] placeholderImage:nil];
  self.lblUserName.text = product.user.fullname;
  self.lblTimestamp.text = [product.created_at relativeDate];
}

+ (CGFloat)getHeight{
  return 40;
}

@end
