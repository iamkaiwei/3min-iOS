//
//  TMEMyListingTableViewCell.m
//  PhotoButton
//
//  Created by Toan Slan on 2/12/14.
//
//

#import "TMEMyListingTableViewCell.h"

@interface TMEMyListingTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewProduct;
@property (weak, nonatomic) IBOutlet UILabel *labelProductName;
@property (weak, nonatomic) IBOutlet UILabel *labelTimestamp;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorLoading;
@property (weak, nonatomic) IBOutlet UILabel *labelProductPrice;

@end

@implementation TMEMyListingTableViewCell

- (void)configCellWithData:(TMEProduct *)product {
	[self.indicatorLoading startAnimating];
	TMEProductImage *img = [product.images firstObject];


	[self.imageViewProduct setImageWithURL:img.thumbURL];

	self.labelProductName.text = product.name;
	self.labelTimestamp.text = [product.createAt relativeDate];
	self.labelProductPrice.text = [NSString stringWithFormat:@"%@ VND", product.price];
	[self.labelProductPrice sizeToFitKeepHeight];
}

+ (CGFloat)getHeight {
	return 132;
}

@end
