//
//  TMEOfferedTableViewCell.m
//  PhotoButton
//
//  Created by Toan Slan on 2/13/14.
//
//

#import "TMEOfferedTableViewCell.h"

@interface TMEOfferedTableViewCell ()

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

- (void)configCellWithData:(TMEConversation *)conversation {
	[self.productIndicator startAnimating];
	[self.avatarIndicator startAnimating];
	self.labelUserName.text = conversation.user_full_name;

	if (conversation.latest_update) {
		self.labelTimestamp.hidden = NO;
		self.imageViewClock.hidden = NO;
		self.labelTimestamp.text = [conversation.latest_update relativeDate];
		[self.labelTimestamp sizeToFit];

		CGRect frame = self.imageViewClock.frame;
		frame.origin.x = CGRectGetMaxX(self.labelTimestamp.frame) + 3;
		self.imageViewClock.frame = frame;
	}

	self.labelOfferPrice.text = [NSString stringWithFormat:@"%@ VND", conversation.offer];

	[self.labelOfferPrice sizeToFitKeepHeight];
	[self.imageViewAvatar sd_setImageWithURL:[NSURL URLWithString:conversation.user_avatar]];

	NSURL *imageURL = [[conversation.product.images lastObject] thumbURL];
	if (imageURL) {
		[self.imageViewProduct sd_setImageWithURL:imageURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
		    if (!cacheType) {
		        self.imageViewProduct.alpha = 0;
			}
		    [self.imageViewProduct fadeInWithDuration:0.5];

        }];
	}
}

+ (CGFloat)getHeight {
	return 116;
}

@end
