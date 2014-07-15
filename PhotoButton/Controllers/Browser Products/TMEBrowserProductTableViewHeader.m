//
//  TMEBrowserProductTableViewHeader.m
//  PhotoButton
//
//  Created by Toan Slan on 2/21/14.
//
//

#import "TMEBrowserProductTableViewHeader.h"

@interface TMEBrowserProductTableViewHeader()

@property (weak, nonatomic) IBOutlet UIImageView *imgUserAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblTimestamp;

@property (weak, nonatomic) IBOutlet UIView *whiteBackgroundForIOS6;
@property (weak, nonatomic) IBOutlet UIToolbar *blurBackground;

@end

@implementation TMEBrowserProductTableViewHeader

- (void)configHeaderWithData:(TMEProduct *)product{
  [self.imgUserAvatar setImageWithURL:[NSURL URLWithString:product.user.photo_url] placeholderImage:nil];
  self.lblUserName.text = product.user.fullname;
  self.lblTimestamp.text = [product.createAt relativeDate];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        self.blurBackground.hidden = YES;
        self.whiteBackgroundForIOS6.backgroundColor = [UIColor whiteColor];
        self.whiteBackgroundForIOS6.alpha = 0.8;
    }
}

+ (CGFloat)getHeight{
  return 40;
}

@end
