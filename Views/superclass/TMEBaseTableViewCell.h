//
//  TMEBaseTableViewCell.h
//  PhotoButton
//
//  Created by Triệu Khang on 27/9/13.
//
//

#import <UIKit/UIKit.h>

@interface TMEBaseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewContent;

- (void)didSelectCellAnimation;
- (void)didDeselectCellAnimation;

@end
