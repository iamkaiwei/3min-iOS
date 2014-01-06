//
//  TMEActivityTableViewCell.m
//  PhotoButton
//
//  Created by admin on 1/2/14.
//
//

#import "TMEActivityTableViewCell.h"

@interface TMEActivityTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *labelUserName;
@property (weak, nonatomic) IBOutlet UILabel *labelTimestamp;
@property (weak, nonatomic) IBOutlet UILabel *labelContent;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewAvatar;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewProduct;

@end

@implementation TMEActivityTableViewCell

- (void)configCellWithConversation:(TMEConversation *)conversation{
  self.labelUserName.text = conversation.user_full_name;
  //  self.labelTimestamp.text = conversation;
  self.labelContent.text = conversation.lastest_message;
  [self.imageViewAvatar setImageWithURL:[NSURL URLWithString:conversation.user_avatar]];
  NSString *imageURL = [(TMEProductImages *)[conversation.product.imagesSet anyObject] medium];
  [self.imageViewProduct setImageWithURL:[NSURL URLWithString:imageURL]];

}

+ (CGFloat)getHeight{
  return 97;
}

@end
