//
//  TMEOfferedTableViewCell.m
//  PhotoButton
//
//  Created by Toan Slan on 2/13/14.
//
//

#import "TMEOfferedTableViewCell.h"

@interface TMEOfferedTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *labelUserName;
@property (weak, nonatomic) IBOutlet UILabel *labelTimestamp;
@property (weak, nonatomic) IBOutlet UILabel *labelOfferPrice;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewAvatar;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewProduct;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewClock;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *productIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *avatarIndicator;

@end

@implementation TMEOfferedTableViewCell

- (void)configCellWithData:(TMEConversation *)conversation{
  self.labelUserName.text = conversation.user_full_name;
  self.labelTimestamp.text = [conversation.latest_update relativeDate];
  [self.labelTimestamp sizeToFit];
  
  CGRect frame = self.imageViewClock.frame;
  frame.origin.x = CGRectGetMaxX(self.labelTimestamp.frame) + 3;
  self.imageViewClock.frame = frame;
  
  self.labelOfferPrice.text = [NSString stringWithFormat:@"$%.2f",conversation.offerValue];
  [self.labelOfferPrice sizeToFitKeepHeight];
  [self.imageViewAvatar setImageWithURL:[NSURL URLWithString:conversation.user_avatar]];
  
  NSString *imageURL = [(TMEProductImages *)[[conversation.product.imagesSet allObjects] lastObject] medium];
  
  if (imageURL) {
    [self.imageViewProduct setImageWithURL:[NSURL URLWithString:imageURL]];
    self.imageViewProduct.hidden = NO;
  }
  
  [self.productIndicator startAnimating];
  [self.avatarIndicator startAnimating];
}

+ (CGFloat)getHeight{
  return 116;
}

@end
