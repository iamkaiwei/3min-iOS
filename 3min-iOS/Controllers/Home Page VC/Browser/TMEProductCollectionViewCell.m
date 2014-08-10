//
//  TMEProductCollectionViewCell.m
//  ThreeMin
//
//  Created by Triệu Khang on 9/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TMEProductCollectionViewCell.h"

@interface TMEProductCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIView *borderRadiusView;

@property (weak, nonatomic) IBOutlet UIImageView *imgProduct;

@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblProductPrice;

@property (weak, nonatomic) IBOutlet UILabel *lblLikeCount;
@property (weak, nonatomic) IBOutlet UILabel *lblCommentCount;

@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblDatetime;

@end

@implementation TMEProductCollectionViewCell

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		// Initialization code
		[self resetContent];
	}
	return self;
}

- (id)init {
	self = [super init];
	if (self) {
		// Initialization code
		[self resetContent];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
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

	self.borderRadiusView.layer.cornerRadius = 3.0f;
	self.borderRadiusView.layer.masksToBounds = YES;
	self.layer.shadowColor = [UIColor colorWithHexString:@"#aaa"].CGColor;
	self.layer.shadowRadius = 0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 1.5f);
    self.layer.shadowOpacity = .3f;

	TMEProductImage *firstImage = [product.images firstObject];
	[self.imgProduct sd_setImageWithURL:firstImage.mediumURL];

	self.lblProductName.text = product.name;

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
