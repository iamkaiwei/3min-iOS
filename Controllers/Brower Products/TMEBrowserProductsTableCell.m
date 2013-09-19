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
    UIImage *image = [PBImageHelper loadImageFromDocuments:img.url];
    [self.imageView setImage:image];
    
    self.lblProductName.text = product.name;
    self.lblProductPrice.text = [product.price stringValue];
}

+ (CGFloat)getHeight{
    return 320;
}

@end
