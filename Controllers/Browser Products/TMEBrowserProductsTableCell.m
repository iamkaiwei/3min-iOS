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

// social
@property (weak, nonatomic) IBOutlet UIButton       * btnFollow;
@property (weak, nonatomic) IBOutlet UIButton       * btnComment;
@property (weak, nonatomic) IBOutlet UIButton       * btnShare;

@end

@implementation TMEBrowserProductsTableCell

- (id)init{
    self = [super init];
    if (self) {
        
        // Follow button
        self.btnFollow.layer.borderWidth = 1;
        self.btnFollow.layer.borderColor = [UIColor grayColor].CGColor;
        self.btnFollow.layer.cornerRadius = 3;
        
        // Comment button
        self.btnComment.layer.borderWidth = 1;
        self.btnComment.layer.borderColor = [UIColor grayColor].CGColor;
        self.btnComment.layer.cornerRadius = 3;
        
        // Share button
        self.btnShare.layer.borderWidth = 1;
        self.btnShare.layer.borderColor = [UIColor grayColor].CGColor;
        self.btnShare.layer.cornerRadius = 3;
    }
    
    return self;
}

- (void)configCellWithProduct:(TMEProduct *)product{
    [self.imgProductImage setImage:nil];
    
    TMEProductImages *img = [product.images anyObject];
    [self.imgProductImage setImageWithURL:[NSURL URLWithString:img.url]];
    [self.imgProductImage clipsToBounds];
    
    self.lblProductName.text = product.name;
    self.lblProductPrice.text = [product.price stringValue];
    
    
}

+ (CGFloat)getHeight{
    return 440;
}

@end
