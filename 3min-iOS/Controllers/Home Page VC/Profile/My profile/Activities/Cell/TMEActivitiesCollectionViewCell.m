//
//  TMEActivitiesCollectionViewCell.m
//  ThreeMin
//
//  Created by Triệu Khang on 24/9/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEActivitiesCollectionViewCell.h"
#import "KHRoundAvatar.h"

@interface TMEActivitiesCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblActivityType;
@property (weak, nonatomic) IBOutlet UILabel *lblActivityComment;
@property (weak, nonatomic) IBOutlet UILabel *lblRelativeDatetime;
@property (weak, nonatomic) IBOutlet KHRoundAvatar *imgAvatar;

@property (weak, nonatomic) IBOutlet UIImageView *imgViewClock;
@property (weak, nonatomic) IBOutlet UIImageView *imgActivityAvatar;

@property (weak, nonatomic) IBOutlet UIView *containLabelsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantContainLabelWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLabelActivityTypeWidth;
@property (copy, nonatomic, readwrite) void (^configBlock)(UICollectionViewCell *cell, TMEActivity *activity);

@end

@implementation TMEActivitiesCollectionViewCell

- (void)awakeFromNib {
	// Initialization code
	[super awakeFromNib];
	[self prepareForReuse];

	[self.contentView mas_makeConstraints: ^(MASConstraintMaker *make) {
	    make.top.equalTo(self);
	    make.trailing.equalTo(self);
	    make.leading.equalTo(self);
	    make.bottom.equalTo(self);
	}];
}

- (void)configWithData:(TMEActivity *)activity {
	self.lblActivityType.text = activity.content;
	[self.imgAvatar setImageWithURL:[NSURL URLWithString:activity.user.avatar]];
	self.lblRelativeDatetime.text = [[[NSDate alloc] initWithTimeIntervalSince1970:[activity.updateTime integerValue]] relativeDate];

	NSString *selName = [NSString stringWithFormat:@"configWith%@:", [activity.subjectType capitalizedString]];
	SEL config = NSSelectorFromString(selName);
	if ([self respondsToSelector:config]) {
		// related link http://stackoverflow.com/questions/7017281/performselector-may-cause-a-leak-because-its-selector-is-unknown
		// same meaning with
		// [self performSelector:config withObject:activity];
		((void (*)(id, SEL, id))[self methodForSelector : config])(self, config, activity);
	}
	[self setNeedsUpdateConstraints];
	[self layoutIfNeeded];
}

- (void)prepareForReuse {
	self.lblActivityComment.hidden = YES;
    self.constantContainLabelWidth.constant = 185;
	self.imgActivityAvatar.hidden = YES;
	self.imgAvatar.image = nil;
	self.imgActivityAvatar.image = nil;
	self.lblActivityComment.text = @"";
	self.lblActivityType.text = @"";
	self.lblRelativeDatetime.text = @"";
}

- (void)_setActivityProductPictureWithActvity:(TMEActivity *)activity {
	if (![activity.displayURL.absoluteString isEqualToString:@""]) {
		[self.imgActivityAvatar setImageWithURL:activity.displayURL];
        return;
	}

    // rezise the content if there is no picture
    self.constantContainLabelWidth.constant = CGRectGetMaxY(self.imgActivityAvatar.frame);
}

// chat
- (void)configWithConversation:(TMEActivity *)activity {
	self.lblActivityComment.hidden = NO;
	self.imgActivityAvatar.hidden = NO;
}

// like
- (void)configWithProduct:(TMEActivity *)activity {
	self.imgActivityAvatar.hidden = NO;
}

// Follow
- (void)configWithRelationship:(TMEActivity *)activity {
	self.imgActivityAvatar.hidden = YES;
}

#pragma mark - Calculate height

- (CGFloat)heightForActivity:(TMEActivity *)activity {
	[self prepareForReuse];
	[self.contentView mas_makeConstraints: ^(MASConstraintMaker *make) {
	    make.top.equalTo(self);
	    make.trailing.equalTo(self);
	    make.leading.equalTo(self);
	    make.bottom.equalTo(self);
	}];

	[self configWithData:activity];
	[self setNeedsUpdateConstraints];
	[self layoutIfNeeded];

	CGFloat height = CGRectGetMaxY(self.containLabelsView.frame);
	CGFloat maxHeight = CGRectGetMaxY(self.imgActivityAvatar.frame);
	CGFloat paddingBottom = 10;

	if (!self.imgActivityAvatar.hidden && height <= maxHeight) {
		return maxHeight + paddingBottom;
	}

	return height + 10;
}

@end
