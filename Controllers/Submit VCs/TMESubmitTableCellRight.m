//
//  TMESubmitTableCellRight.m
//  PhotoButton
//
//  Created by admin on 12/25/13.
//
//

#import "TMESubmitTableCellRight.h"

@interface TMESubmitTableCellRight()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UIView *separatorView;

@end

@implementation TMESubmitTableCellRight

- (void)configCellWithMessage:(TMEMessage *)message andSeller:(TMEUser *)seller
{
    if ([message.from.id isEqual:seller.id]) {
        self.lblUsername.text = seller.fullname;
        [self.imageViewAvatar setImageWithURL:[NSURL URLWithString:seller.photo_url]];
    }
    else
    {
        self.lblUsername.text = message.from.fullname;
        [self.imageViewAvatar setImageWithURL:[NSURL URLWithString:message.from.photo_url]];
    }
    
    self.lblContent.text = message.chat;
    [self.lblContent sizeToFitKeepWidth];
    
    [self.separatorView alignBelowView:self.lblContent offsetY:7 sameWidth:NO];
    self.lblTime.text = [message.time_stamp relativeDate];
}

+ (CGFloat)getHeight{
    return 111;
}

@end