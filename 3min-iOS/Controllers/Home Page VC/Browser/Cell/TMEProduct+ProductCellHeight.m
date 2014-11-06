//
//  TMEProduct+ProductCellHeight.m
//  ThreeMin
//
//  Created by Triệu Khang on 3/9/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

static void *kProductCellHeight = &kProductCellHeight;

#import <objc/runtime.h>
#import "TMEProduct+ProductCellHeight.h"

@implementation TMEProduct (ProductCellHeight)

- (CGFloat)productCellHeight {
	CGFloat cellWidth = 152;
	TMEProduct *product = self;
	TMEProductImage *image = [product.images firstObject];
	CGSize imageDim = [image.dim CGSizeValue];

    if (CGSizeEqualToSize([image.dim CGSizeValue], CGSizeZero)) {
        imageDim = CGSizeMake(150, 150);
    }

	NSNumber *height = objc_getAssociatedObject(self, kProductCellHeight);

	if ([height floatValue] == 0 || isnan([height floatValue])) {
		CGFloat bottomHeight = [TMEProductCollectionViewCell staticBottomInformationHeightWithProduct:product];
		CGFloat newCellHeight = imageDim.height * cellWidth / imageDim.width + bottomHeight;
		[self setProductCellHeight:newCellHeight];
		return newCellHeight;
	}
    
	return [height floatValue];
}

- (void)setProductCellHeight:(CGFloat)productCellHeight {
	NSNumber *height = @(productCellHeight);
	objc_setAssociatedObject(self, kProductCellHeight, height, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
