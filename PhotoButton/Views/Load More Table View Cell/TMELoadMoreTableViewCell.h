//
//  TMELoadMoreTableViewCell.h
//  PhotoButton
//
//  Created by Toan Slan on 1/9/14.
//
//

#import "TMEBaseTableViewCell.h"

@interface TMELoadMoreTableViewCell : TMEBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelLoading;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorLoading;

- (void)startLoading;
+ (NSString *)getIdentifier;
+ (CGFloat)getHeight;

@end
