//
//  TMELikedTableViewCell.m
//  PhotoButton
//
//  Created by Toan Slan on 2/17/14.
//
//

#import "TMELikedTableViewCell.h"

@interface TMELikedTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewProduct;
@property (weak, nonatomic) IBOutlet UILabel *labelProductName;
@property (weak, nonatomic) IBOutlet UILabel *labelTimestamp;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorLoading;
@property (weak, nonatomic) IBOutlet UILabel *labelProductPrice;

@end

@implementation TMELikedTableViewCell

- (void)configCellWithData:(TMEProduct *)product{
  [self.indicatorLoading startAnimating];
  TMEProductImages *img = [product.images anyObject];
  [self.imageViewProduct setImageWithURL:[NSURL URLWithString:img.medium]];
  self.labelProductName.text = product.name;
  self.labelTimestamp.text = [product.created_at relativeDate];
  self.labelProductPrice.text = [NSString stringWithFormat:@"$%@", [product.price stringValue]];
  [self.labelProductPrice sizeToFitKeepHeight];
}

+ (CGFloat)getHeight{
  return 132;
}

@end
