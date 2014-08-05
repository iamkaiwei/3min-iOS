//
//  TMELeftMenuTableViewCell.m
//  PhotoButton
//
//  Created by Triệu Khang on 27/10/13.
//
//

#import "TMELeftMenuTableViewCell.h"

@interface TMELeftMenuTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView        * imageViewCategoryAvatar;
@property (weak, nonatomic) IBOutlet UILabel            * lblCategoryName;

@end

@implementation TMELeftMenuTableViewCell

+ (CGFloat )getHeight
{
    return 64;
}

- (void)configCellWithData:(TMECategory *)category
{
    self.lblCategoryName.text = category.name;
    [self.imageViewCategoryAvatar sd_setImageWithURL:[NSURL URLWithString:category.image.urlString]];
}

@end
