//
//  TMEListOffersTableViewCell.m
//  PhotoButton
//
//  Created by Toan Slan on 3/3/14.
//
//

#import "TMEListOffersTableViewCell.h"

@interface TMEListOffersTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *labelUserName;
@property (weak, nonatomic) IBOutlet UILabel *labelContent;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewAvatar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *avatarIndicator;

@end

@implementation TMEListOffersTableViewCell

- (void)configCellWithData:(TMEConversation *)conversation{
    self.labelUserName.text = conversation.userFullname;
    self.labelContent.text = [NSString stringWithFormat:NSLocalizedString(@"Offers %@ VND", nil),[conversation.offer stringValue]];
    [self.imageViewAvatar setImageWithURL:[NSURL URLWithString:conversation.userAvatar]];
    [self.avatarIndicator startAnimating];
}

+ (CGFloat)getHeight{
    return 97;
}

@end
