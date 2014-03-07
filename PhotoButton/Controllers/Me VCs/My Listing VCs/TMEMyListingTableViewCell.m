//
//  TMEMyListingTableViewCell.m
//  PhotoButton
//
//  Created by Toan Slan on 2/12/14.
//
//

#import "TMEMyListingTableViewCell.h"

@interface TMEMyListingTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewProduct;
@property (weak, nonatomic) IBOutlet UILabel *labelProductName;
@property (weak, nonatomic) IBOutlet UILabel *labelTimestamp;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorLoading;
@property (weak, nonatomic) IBOutlet UILabel *labelProductPrice;

@end

@implementation TMEMyListingTableViewCell

- (void)configCellWithData:(TMEProduct *)product{
  [self.indicatorLoading startAnimating];
  TMEProductImages *img = [product.images anyObject];
  
  [self.imageViewProduct setImageWithURL:[NSURL URLWithString:img.thumb] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
    if (!cacheType) {
      self.imageViewProduct.alpha = 0;
    }
    [self.imageViewProduct fadeInWithDuration:0.5];
  }];
  
  self.labelProductName.text = product.name;
  self.labelTimestamp.text = [product.created_at relativeDate];
  self.labelProductPrice.text = [NSString stringWithFormat:@"%@ VND", product.price];
  [self.labelProductPrice sizeToFitKeepHeight];
}

+ (CGFloat)getHeight{
  return 132;
}

@end
