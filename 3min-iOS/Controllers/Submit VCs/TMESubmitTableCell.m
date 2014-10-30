//
//  TMESubmitTableCell.m
//  PhotoButton
//
//  Created by Toan Slan on 12/23/13.
//
//

#import "TMESubmitTableCell.h"
#import "KHRoundAvatar.h"

@interface TMESubmitTableCell()

@property (weak, nonatomic) IBOutlet KHRoundAvatar *imageViewAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation TMESubmitTableCell

- (void)awakeFromNib
{
    self.lblTime.font = [UIFont openSansRegularFontWithSize:self.lblTime.font.pointSize];
    self.lblContent.font = [UIFont openSansRegularFontWithSize:self.lblContent.font.pointSize];
}

- (void)configCellWithMessage:(TMEReply *)reply
{
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

+ (CGFloat)getHeight{
    return 77;
}

- (CGFloat)getHeightWithContent:(NSString *)content{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 22)];
    label.numberOfLines = 0;
    label.font = [UIFont openSansRegularFontWithSize:17.0f];
    label.text = content;
    [label sizeToFitKeepWidth];
    return [TMESubmitTableCell getHeight] + label.height - 22;
}

@end
