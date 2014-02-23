//
//  TMEBrowserProductTableViewHeader.h
//  PhotoButton
//
//  Created by Toan Slan on 2/21/14.
//
//

#import <UIKit/UIKit.h>

@interface TMEBrowserProductTableViewHeader : UITableViewHeaderFooterView

- (void)configHeaderWithData:(TMEProduct *)product;
+ (CGFloat)getHeight;

@end
