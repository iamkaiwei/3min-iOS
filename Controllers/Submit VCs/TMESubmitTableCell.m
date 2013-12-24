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
@property (weak, nonatomic) IBOutlet UITextView *textViewContent;

@end

@implementation TMESubmitTableCell

- (void)configCellWithConversation:(TMETransaction *)transaction andSeller:(TMEUser *)seller
{
    self.lblUsername.text = seller.username;
    [self.imageViewAvatar setImageWithURL:[NSURL URLWithString:seller.photo_url]];
    
    if (transaction.from) {
        self.lblUsername.text = transaction.from.fullname;
        [self.imageViewAvatar setImageWithURL:[NSURL URLWithString:transaction.from.photo_url]];
    }
    
    self.textViewContent.text = transaction.chat;
    self.lblTime.text = [transaction.time_stamp relativeDate];
    self.lblUsername.text = transaction.from.name;
}

@end
