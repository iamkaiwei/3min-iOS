//
//  TMEBrowerProductsViewController.h
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "YIFullScreenScroll.h"

@interface TMEBrowserProductsViewController : TMEBaseTableViewController

@property (strong, nonatomic) TMECategory               * currentCategory;

- (void)loadProductsWithPage:(NSInteger)page;
- (void)fullScreenScrollDidLayoutUIBars:(YIFullScreenScroll *)fullScreenScroll;

@end