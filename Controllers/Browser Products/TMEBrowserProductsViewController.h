//
//  TMEBrowerProductsViewController.h
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "YIFullScreenScroll.h"

@interface TMEBrowserProductsViewController : TMEBaseTableViewController

- (void)loadProducts;
- (void)fullScreenScrollDidLayoutUIBars:(YIFullScreenScroll *)fullScreenScroll;

@end