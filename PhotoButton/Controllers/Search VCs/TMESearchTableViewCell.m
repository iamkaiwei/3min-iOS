//
//  TMESearchTableViewCell.m
//  PhotoButton
//
//  Created by Toan Slan on 2/24/14.
//
//

#import "TMESearchTableViewCell.h"

@interface TMESearchTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewProduct;
@property (weak, nonatomic) IBOutlet UILabel *labelProductName;
@property (weak, nonatomic) IBOutlet UILabel *labelTimestamp;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorLoading;
@property (weak, nonatomic) IBOutlet UILabel *labelProductPrice;

@end

@implementation TMESearchTableViewCell

- (void)configCellWithData:(TMEProduct *)product {
	[self.indicatorLoading startAnimating];
	TMEProductImage *img = [product.images firstObject];

	[self.imageViewProduct sd_setImageWithURL:img.mediumURL completed: ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
	    if (!cacheType) {
	        self.imageViewProduct.alpha = 0;
		}
	    [self.imageViewProduct fadeInWithDuration:0.5];
	}];

	self.labelProductName.text = product.name;
	self.labelTimestamp.text = [product.createAt relativeDate];
	self.labelProductPrice.text = [NSString stringWithFormat:@"%@ VND", product.price];
	[self.labelProductPrice sizeToFitKeepHeight];
}

+ (CGFloat)getHeight {
	return 132;
}

@end
