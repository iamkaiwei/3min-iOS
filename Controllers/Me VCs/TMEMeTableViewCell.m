//
//  TMEMeTableViewCell.m
//  PhotoButton
//
//  Created by Toan Slan on 1/2/14.
//
//

#import "TMEMeTableViewCell.h"

@interface TMEMeTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *labelCellTitle;


@end

@implementation TMEMeTableViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)configCellWithTitle:(NSString *)title{
  self.labelCellTitle.text = title;
}

+ (CGFloat)getHeight{
  return 44;
}

@end
