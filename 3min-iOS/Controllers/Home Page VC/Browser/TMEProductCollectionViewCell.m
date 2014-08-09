//
//  TMEProductCollectionViewCell.m
//  ThreeMin
//
//  Created by Triệu Khang on 9/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductCollectionViewCell.h"

@interface TMEProductCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgProduct;

@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblProductPrice;

@property (weak, nonatomic) IBOutlet UILabel *lblLikeCount;
@property (weak, nonatomic) IBOutlet UILabel *lblCommentCount;

@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblDatetime;

@end

@implementation TMEProductCollectionViewCell

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        [self resetContent];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self resetContent];
    }
    return self;
}

- (void)configWithData:(TMEProduct *)product {
    NSCParameterAssert(product);
    NSAssert([product isKindOfClass:[TMEProduct class]], @"Need product to config product cell");

    TMEProductImage *firstImage = [product.images firstObject];
    [self.imgProduct sd_setImageWithURL:firstImage.mediumURL];

    self.lblProductName.text = product.name;
    self.lblProductPrice.text = [product.price stringValue];

    self.lblLikeCount.text = [product.likes stringValue];

    self.lblUsername.text = product.user.name;
    self.lblUsername.text = [product.createAt relativeDate];
}

- (void)resetContent {

    self.imgProduct.image = nil;

    self.lblProductName.text = @"";
    self.lblProductPrice.text = @"";

    self.lblLikeCount.text = @"";
    self.lblCommentCount.text = @"";

    self.lblDatetime.text = @"";
    self.lblUsername.text = @"";
}

@end
