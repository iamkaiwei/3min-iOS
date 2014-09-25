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

	self.configBlock = ^void (UICollectionViewCell *cell, TMEActivity *activity) {
		weakSelf.lblActivityType.text = activity.content;
		[weakSelf.imgViewClock mas_remakeConstraints: ^(MASConstraintMaker *make) {
		    make.bottom.equalTo(weakSelf.contentView).with.offset(10).with.priorityLow();
		}];

        [weakSelf layoutIfNeeded];
	};
}

- (void)configWithData:(TMEActivity *)activity {
	self.configBlock(self, activity);
	[self setNeedsUpdateConstraints];
	[self layoutIfNeeded];
}

- (void)updateConstraints {
	[super updateConstraints];
}

@end
