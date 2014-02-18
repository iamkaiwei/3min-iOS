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
  [self.imageViewProduct setImageWithURL:[NSURL URLWithString:img.medium]];
  self.labelProductName.text = product.name;
  self.labelTimestamp.text = [product.created_at relativeDate];
  self.labelProductPrice.text = [NSString stringWithFormat:@"$%.2f", product.priceValue];
  [self.labelProductPrice sizeToFitKeepHeight];
}

+ (CGFloat)getHeight{
  return 132;
}

@end
