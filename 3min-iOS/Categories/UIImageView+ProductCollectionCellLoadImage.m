//
//  UIImageView+ProductCollectionCellLoadImage.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/9/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "UIImageView+ProductCollectionCellLoadImage.h"
#import "UIImageView+AFNetworking.h"

@implementation UIImageView (ProductCollectionCellLoadImage)

- (void)tme_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage {
	NSURLRequest *request;
	if ([url isKindOfClass:[NSString class]]) {
		request = [NSURLRequest requestWithURL:[NSURL URLWithString:(NSString *)url]];
	}
	else {
		request = [NSURLRequest requestWithURL:url];
	}

	UIImage *image = [[UIImageView sharedImageCache] cachedImageForRequest:request];
	if (image) {
		[self setImage:image];
		return;
	}

	[self setImageWithURLRequest:request placeholderImage:placeholderImage success:nil failure:nil];
}

@end
