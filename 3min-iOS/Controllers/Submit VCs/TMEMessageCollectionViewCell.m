//
//  TMEMessageCollectionViewCell.m
//  ThreeMin
//
//  Created by iSlan on 11/7/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEMessageCollectionViewCell.h"

@interface TMEMessageCollectionViewCell()

@property (weak, nonatomic) IBOutlet KHRoundAvatar *imageViewAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation TMEMessageCollectionViewCell

- (void)configWithData:(id)data {
    if (![data isMemberOfClass:[TMEReply class]]) {
        return;
    }
    TMEReply *reply = data;
    
    [self.imageViewAvatar setImageWithURL:[NSURL URLWithString:reply.userAvatar]];
    self.lblContent.text = reply.reply;
    [self updateConstraints];
    
    if (reply.timeStamp) {
        [self.indicator stopAnimating];
        self.lblTime.text = [reply.timeStamp relativeDate];
        return;
    }
    
    self.indicator.hidden = NO;
    self.lblTime.text = NSLocalizedString(@"Pending...", nil);
}

@end
