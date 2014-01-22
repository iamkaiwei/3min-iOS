//
//  TMEBrowerProductsTableCell.m
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "TMEBrowserProductsTableCell.h"
#import "PBImageHelper.h"
#import "SDWebImageOperation.h"

@interface TMEBrowserProductsTableCell()

// product

@property (weak, nonatomic) IBOutlet UIButton        * btnProductCategory;
@property (weak, nonatomic) IBOutlet UILabel         * lblProductName;
@property (weak, nonatomic) IBOutlet UILabel         * lblProductPrice;
@property (weak, nonatomic) IBOutlet UIImageView     * imageViewProduct;

// user
@property (weak, nonatomic) IBOutlet UIImageView    * imgUserAvatar;
@property (weak, nonatomic) IBOutlet UILabel        * lblUserName;
@property (weak, nonatomic) IBOutlet UILabel        * lblTimestamp;

// social
@property (weak, nonatomic) IBOutlet UIButton       * btnFollow;
@property (weak, nonatomic) IBOutlet UIButton       * btnComment;
@property (weak, nonatomic) IBOutlet UIButton       * btnShare;

@property (weak, nonatomic) IBOutlet UIImageView *imgCategoryCover;

@end

@implementation TMEBrowserProductsTableCell

- (void)configCellWithProduct:(TMEProduct *)product{
    
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
    
    // for now when we get product, we get all imformantion about this product like user, category, etc.
  
    // user
    [self.imgUserAvatar setImageWithURL:[NSURL URLWithString:product.user.photo_url] placeholderImage:nil];
    self.lblUserName.text = product.user.fullname;
    self.lblTimestamp.text = [product.created_at relativeDate];
    
    NSURL *imageURL = [NSURL URLWithString:product.category.photo_url];
    [self.imgCategoryCover setImageWithURL:imageURL placeholderImage:nil];
    
    TMEProductImages *img = [product.images anyObject];

    [[XLCircleProgressIndicator appearance] setStrokeProgressColor:[UIColor orangeMainColor]];
    [[XLCircleProgressIndicator appearance] setStrokeRemainingColor:[UIColor whiteColor]];
    [[XLCircleProgressIndicator appearance] setStrokeWidth:3.0f];
  
    [self.imageViewProduct setImageWithProgressIndicatorAndURL:[NSURL URLWithString:img.medium]
                                            placeholderImage:[UIImage imageNamed:@"photo-placeholder"]];
  
    self.lblProductName.text = product.name;
    self.lblProductPrice.text = [NSString stringWithFormat:@"$%@", [product.price stringValue]];
    
}
- (IBAction)onBtnComment:(id)sender {
    if ([self.delegate respondsToSelector:@selector(onBtnComment:)]) {
        [self.delegate performSelector:@selector(onBtnComment:) withObject:sender];
    }
}

+ (CGFloat)getHeight{
    return 440;
}

@end
