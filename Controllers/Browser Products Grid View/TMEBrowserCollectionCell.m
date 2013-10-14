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

- (void)configCellWithProduct:(TMEProduct *)product
{
    self.backgroundColor = [UIColor whiteColor];
    self.imgProduct.image = nil;
    
    NSArray *images = [product.images allObjects];
    
    if (images.count > 0) {
        NSURL *imageUrl = [NSURL URLWithString:(NSString *)[[images objectAtIndex:0] url]];
        [self.imgProduct setImageWithURL:imageUrl placeholderImage:nil];
    }
    
    self.lblProductName.text = product.name;
    self.lblProductPrice.text = [product.price stringValue];
}

+ (CGSize)productCellSize
{
    return CGSizeMake(150, 190);
}

@end
