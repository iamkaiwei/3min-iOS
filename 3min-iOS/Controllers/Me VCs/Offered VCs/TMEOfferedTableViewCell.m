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
	self.labelUserName.text = conversation.userFullname;

	if (conversation.latestUpdate) {
		self.labelTimestamp.hidden = NO;
		self.imageViewClock.hidden = NO;
		self.labelTimestamp.text = [conversation.latestUpdate relativeDate];
		[self.labelTimestamp sizeToFit];

		CGRect frame = self.imageViewClock.frame;
		frame.origin.x = CGRectGetMaxX(self.labelTimestamp.frame) + 3;
		self.imageViewClock.frame = frame;
	}

	self.labelOfferPrice.text = [NSString stringWithFormat:@"%@ VND", conversation.offer];

	[self.labelOfferPrice sizeToFitKeepHeight];
	[self.imageViewAvatar setImageWithURL:[NSURL URLWithString:conversation.userAvatar]];

	NSURL *imageURL = [[conversation.product.images lastObject] thumbURL];
	if (imageURL) {
		[self.imageViewProduct setImageWithURL:imageURL];
	}
}

+ (CGFloat)getHeight {
	return 116;
}

@end
