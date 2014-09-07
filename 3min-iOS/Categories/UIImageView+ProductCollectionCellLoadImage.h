//
//  UIImageView+ProductCollectionCellLoadImage.h
//  ThreeMin
//
//  Created by Triệu Khang on 4/9/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ProductCollectionCellLoadImage)

- (void)tme_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage;
- (BOOL)tme_loadCachedImageWithUrl:(NSURL *)url;

@end
