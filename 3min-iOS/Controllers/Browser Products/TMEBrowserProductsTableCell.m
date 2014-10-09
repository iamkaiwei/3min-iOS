//
//  TMEBrowerProductsTableCell.m
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "TMEBrowserProductsTableCell.h"
#import "PBImageHelper.h"

@interface TMEBrowserProductsTableCell ()

// product
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblProductPrice;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewProduct;
@property (weak, nonatomic) IBOutlet UILabel *labelLikes;

// social
@property (weak, nonatomic) IBOutlet UIButton *btnFollow;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;


@end

@implementation TMEBrowserProductsTableCell

- (void)configCellWithData:(TMEProduct *)product {
    self.labelLikes.text = NSStringf(@"%d", product.likeCount);
	[self.labelLikes sizeToFitKeepHeight];

	self.btnFollow.selected = product.likedValue;

	TMEProductImage *img = [product.images firstObject];

	[self.imageViewProduct setImageWithURL:img.mediumURL
	                         placeholderImage:[UIImage imageNamed:@"photo-placeholder"]];

	self.lblProductName.text = product.name;
	self.lblProductPrice.text = [NSString stringWithFormat:@"%@ VND", product.price];

	[self.lblProductPrice sizeToFitKeepHeightAlignRight];
}

- (IBAction)onBtnLike:(id)sender {
	if ([self.delegate respondsToSelector:@selector(onBtnLike:label:)]) {
		[self.delegate performSelector:@selector(onBtnLike:label:) withObject:sender withObject:self.labelLikes];
	}
}

+ (CGFloat)getHeight {
	return 408;
}

@end
