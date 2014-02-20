//
//  TMEBrowserCollectionCell.m
//  PhotoButton
//
//  Created by Triệu Khang on 13/10/13.
//
//

#import "TMEBrowserCollectionCell.h"

@interface TMEBrowserCollectionCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgProduct;
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblProductPrice;

@end

@implementation TMEBrowserCollectionCell

- (id)init
{
  self = [super init];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
  }
  
  return self;
}

- (void)configCellWithData:(TMEProduct *)product
{
  self.backgroundColor = [UIColor whiteColor];
  self.imgProduct.image = nil;
  
  NSArray *images = [product.images allObjects];
  
  if (images.count > 0) {
    TMEProductImages *image = [images objectAtIndex:0];
    NSURL *imageUrl = [NSURL URLWithString:(NSString *)image.thumb];
    [self.imgProduct setImageWithURL:imageUrl placeholderImage:nil];
  }
  
  self.lblProductName.text = product.name;
  self.lblProductPrice.text = [NSString stringWithFormat:@"$%@", product.price];
}

+ (CGSize)productCellSize
{
  return CGSizeMake(153, 190);
}

@end
