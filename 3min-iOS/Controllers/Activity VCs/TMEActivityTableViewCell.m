//
//  TMEActivityTableViewCell.m
//  PhotoButton
//
//  Created by admin on 1/2/14.
//
//

#import "TMEActivityTableViewCell.h"

@interface TMEActivityTableViewCell ()

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

- (void)configCellWithData:(TMEConversation *)conversation {
	self.labelUserName.text = conversation.userFullname;
	self.labelTimestamp.text = [conversation.latestUpdate relativeDate];
	[self.labelTimestamp sizeToFit];

	CGRect frame = self.imageViewClock.frame;
	frame.origin.x = CGRectGetMaxX(self.labelTimestamp.frame) + 3;
	self.imageViewClock.frame = frame;

	self.labelContent.text = conversation.latestMessage;
	[self.imageViewAvatar setImageWithURL:[NSURL URLWithString:conversation.userAvatar]];

	NSURL *imageURL = [[conversation.product.images lastObject] thumbURL];

	if (imageURL) {
		[self.imageViewProduct setImageWithURL:imageURL];
	}

	[self.productIndicator startAnimating];
	[self.avatarIndicator startAnimating];
}

+ (CGFloat)getHeight {
	return 97;
}

@end
