//
//  TMELoadMoreTableViewCell.h
//  PhotoButton
//
//  Created by Toan Slan on 1/9/14.
//
//

#import "TMEBaseTableViewCell.h"

@interface TMELoadMoreTableViewCell : TMEBaseTableViewCell
@property (weak, nonatomic) IBOutlet MTAnimatedLabel *labelLoading;

- (void)startLoading;
+ (CGFloat)getHeight;

@end
