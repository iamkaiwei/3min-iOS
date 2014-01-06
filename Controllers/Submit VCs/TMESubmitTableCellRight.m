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

- (void)configCellWithMessage:(TMEReply *)reply{
  self.lblUsername.text = reply.user_full_name;
  [self.imageViewAvatar setImageWithURL:[NSURL URLWithString:reply.user_avatar]];
  
  self.lblContent.text = reply.reply;
  [self.lblContent sizeToFitKeepWidth];
  
  [self.separatorView alignBelowView:self.lblContent offsetY:7 sameWidth:NO];
//  self.lblTime.text = [reply.time_stamp relativeDate];
}

+ (CGFloat)getHeight{
  return 111;
}

@end