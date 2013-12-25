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

@end

@implementation TMESubmitTableCell

- (void)configCellWithConversation:(TMETransaction *)transaction andSeller:(TMEUser *)seller
{
    if (transaction.from) {
        self.lblUsername.text = transaction.from.fullname;
        [self.imageViewAvatar setImageWithURL:[NSURL URLWithString:transaction.from.photo_url]];
    }
    else
    {
        self.lblUsername.text = seller.username;
        [self.imageViewAvatar setImageWithURL:[NSURL URLWithString:seller.photo_url]];
    }
    
    self.lblContent.text = transaction.chat;
    [self.lblContent sizeToFitKeepWidth];
    self.lblTime.text = [transaction.time_stamp relativeDate];
    self.lblUsername.text = transaction.from.name;
}

+ (CGFloat)getHeight{
    return 107;
}

- (CGFloat)getHeightWithContent:(NSString *)content{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 297, 26)];
    label.text = content;
    [label sizeToFitKeepWidth];
    return [TMESubmitTableCell getHeight] + [label expectedHeight] - 26;
}

@end