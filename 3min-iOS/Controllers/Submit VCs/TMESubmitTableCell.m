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

- (void)configCellWithMessage:(TMEReply *)reply
{
  self.lblUsername.text = reply.userFullName;
  [self.imageViewAvatar setImageWithURL:[NSURL URLWithString:reply.userAvatar]];
  
  self.lblContent.text = reply.reply;
  [self.lblContent sizeToFitKeepWidth];
  [self.separatorView alignBelowView:self.lblContent offsetY:7 sameWidth:NO];
  
  if (reply.timeStamp) {
    [self.indicator stopAnimating];
    self.lblTime.text = [reply.timeStamp relativeDate];
    return;
  }
  
  self.indicator.hidden = NO;
  self.lblTime.text = NSLocalizedString(@"Pending...", nil);
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
