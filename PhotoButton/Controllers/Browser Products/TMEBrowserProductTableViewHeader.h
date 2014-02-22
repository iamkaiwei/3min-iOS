//
//  TMEBrowserProductTableViewHeader.h
//  PhotoButton
//
//  Created by Toan Slan on 2/21/14.
//
//

#import <UIKit/UIKit.h>

@interface TMEBrowserProductTableViewHeader : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIImageView *imgUserAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblTimestamp;

- (void)configHeaderWithData:(TMEProduct *)product;
+ (CGFloat)getHeight;
@end
