//
//  TMELoadMoreTableViewCell.h
//  PhotoButton
//
//  Created by Toan Slan on 1/9/14.
//
//

#import "TMEBaseTableViewCell.h"

@protocol TMELoadMoreTableViewCellDelegate <NSObject>

- (void)onBtnLoadMore:(UIButton *)sender;

@end

@interface TMELoadMoreTableViewCell : TMEBaseTableViewCell

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorLoadMoreButton;
@property (assign, nonatomic) id <TMELoadMoreTableViewCellDelegate> delegate;

@end
