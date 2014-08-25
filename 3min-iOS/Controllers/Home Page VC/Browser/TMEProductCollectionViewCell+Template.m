//
//  TMEProductCollectionViewCell+Template.m
//  ThreeMin
//
//  Created by Triệu Khang on 22/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductCollectionViewCell+Template.h"

@implementation TMEProductCollectionViewCell (Template)

+ (instancetype)sharedTemplate {
	static TMEProductCollectionViewCell *cell = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
        UINib *templateNib = [UINib nibWithNibName:@"TMEProductCollectionViewCell" bundle:[NSBundle mainBundle]];
        cell = [[templateNib instantiateWithOwner:nil options:nil] firstObject];
	});

	return cell;
}

- (CGFloat)staticBottomInformationHeightWithProduct:(TMEProduct *)product {
    CGFloat oneLineHeight = 21;
    CGFloat bottomStaticHeight = 152;

    TMEProductCollectionViewCell *cell = [TMEProductCollectionViewCell sharedTemplate];
	[cell prepareForReuse];
    cell.lblProductName.preferredMaxLayoutWidth = cell.lblProductName.width;
	[cell configWithData:product];
    [cell layoutIfNeeded];
	return cell.lblProductName.height + bottomStaticHeight - oneLineHeight;
}

@end
