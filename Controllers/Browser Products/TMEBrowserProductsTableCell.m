//
//  TMEBrowerProductsTableCell.m
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "TMEBrowserProductsTableCell.h"
#import "PBImageHelper.h"

@interface TMEBrowserProductsTableCell()

@property (weak, nonatomic) IBOutlet UIImageView    * imgProductImage;
@property (weak, nonatomic) IBOutlet UILabel        * lblProductName;
@property (weak, nonatomic) IBOutlet UILabel        * lblProductPrice;

@end

@implementation TMEBrowserProductsTableCell

- (void)configCellWithProduct:(TMEProduct *)product{
    TMEProductImages *img = [product.images anyObject];
    [self.imgProductImage setImageWithURL:[NSURL URLWithString:img.url]];
    [self.imgProductImage clipsToBounds];
    
    self.lblProductName.text = product.name;
    self.lblProductPrice.text = [product.price stringValue];
}

+ (CGFloat)getHeight{
    return 310;
}

@end
