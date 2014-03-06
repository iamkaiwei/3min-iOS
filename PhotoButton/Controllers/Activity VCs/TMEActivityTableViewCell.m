//
//  TMEActivityTableViewCell.m
//  PhotoButton
//
//  Created by admin on 1/2/14.
//
//

#import "TMEActivityTableViewCell.h"

@interface TMEActivityTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *labelUserName;
@property (weak, nonatomic) IBOutlet UILabel *labelTimestamp;
@property (weak, nonatomic) IBOutlet UILabel *labelContent;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewAvatar;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewProduct;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewClock;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *productIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *avatarIndicator;

@end

@implementation TMEActivityTableViewCell

- (void)configCellWithData:(TMEConversation *)conversation{
  
  self.labelUserName.text = conversation.user_full_name;
  self.labelTimestamp.text = [conversation.latest_update relativeDate];
  [self.labelTimestamp sizeToFit];
  
  CGRect frame = self.imageViewClock.frame;
  frame.origin.x = CGRectGetMaxX(self.labelTimestamp.frame) + 3;
  self.imageViewClock.frame = frame;
  
  self.labelContent.text = conversation.latest_message;
  [self.imageViewAvatar setImageWithURL:[NSURL URLWithString:conversation.user_avatar]];
  
  NSString *imageURL = [(TMEProductImages *)[[conversation.product.imagesSet allObjects] lastObject] thumb];
  
  if (imageURL) {
    [self.imageViewProduct setImageWithURL:[NSURL URLWithString:imageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
      if (!cacheType) {
        self.imageViewProduct.alpha = 0;
      }
      [self.imageViewProduct fadeInWithDuration:0.5];
    }];
  }
  
  [self.productIndicator startAnimating];
  [self.avatarIndicator startAnimating];
}

+ (CGFloat)getHeight{
  return 97;
}

@end
