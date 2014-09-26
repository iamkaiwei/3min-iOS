//
//  TMEActivitiesCollectionViewCell.m
//  ThreeMin
//
//  Created by Triệu Khang on 24/9/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEActivitiesCollectionViewCell.h"

@interface TMEActivitiesCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblActivityType;
@property (weak, nonatomic) IBOutlet UILabel *lblActivityComment;
@property (weak, nonatomic) IBOutlet UILabel *lblRelativeDatetime;

@property (copy, nonatomic, readwrite) void (^configBlock)(UICollectionViewCell *cell, TMEActivity *activity);
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation TMEActivitiesCollectionViewCell

- (void)awakeFromNib {
	// Initialization code
	__weak typeof(self) weakSelf = self;

    [super awakeFromNib];

	[weakSelf.contentView mas_remakeConstraints: ^(MASConstraintMaker *make) {
	    make.leading.equalTo(weakSelf);
	    make.trailing.equalTo(weakSelf);
	    make.top.equalTo(weakSelf);
	    make.bottom.equalTo(weakSelf);
	}];

	self.configBlock = ^void (UICollectionViewCell *cell, TMEActivity *activity) {
		weakSelf.lblActivityType.text = activity.content;
	};
}

- (void)configWithData:(TMEActivity *)activity {
	self.configBlock(self, activity);
	[self setNeedsUpdateConstraints];
	[self layoutIfNeeded];
}

@end
