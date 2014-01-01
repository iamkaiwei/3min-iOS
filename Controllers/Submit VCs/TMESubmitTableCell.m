//
//  TMESubmitTableCell.m
//  PhotoButton
//
//  Created by Toan Slan on 12/23/13.
//
//

#import "TMESubmitTableCell.h"

@interface TMESubmitTableCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIView *separatorView;

@end

@implementation TMESubmitTableCell

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
    
    if (message.time_stamp) {
        [self.indicator stopAnimating];
        self.lblTime.text = [message.time_stamp relativeDate];
        return;
    }
    
    self.indicator.hidden = NO;
    self.lblTime.text = @"Pending...";
}

+ (CGFloat)getHeight{
    return 111;
}

- (CGFloat)getHeightWithContent:(NSString *)content{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 295, 26)];
    label.text = content;
    [label sizeToFitKeepWidth];
    return [TMESubmitTableCell getHeight] + [label expectedHeight] - 26;
}

@end
