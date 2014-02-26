//
//  TMEBrowerProductsViewController.h
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "YIFullScreenScroll.h"

@interface TMEBrowserProductsViewController : TMEBaseTableViewController
@property (assign, nonatomic) NSInteger                   currentPage;

- (void)loadProductsWithPage:(NSInteger)page;
- (void)fullScreenScrollDidLayoutUIBars:(YIFullScreenScroll *)fullScreenScroll;

@end