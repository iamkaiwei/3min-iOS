//
//  TMEBaseTableViewCell.m
//  PhotoButton
//
//  Created by Triệu Khang on 27/9/13.
//
//

#import "TMEBaseTableViewCell.h"

@implementation TMEBaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.layer.shouldRasterize = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
