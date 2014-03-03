//
//  TMEBrowserCollectionViewController.h
//  PhotoButton
//
//  Created by Triệu Khang on 13/10/13.
//
//

#import <UIKit/UIKit.h>

@interface TMEBrowserCollectionViewController : TMEBaseViewController

@property (assign, nonatomic) BOOL                            paging;
@property (assign, nonatomic) NSInteger                       currentPage;
@property (strong, nonatomic) NSMutableArray                * arrayProducts;
@property (strong, nonatomic) TMECategory                   * currentCategory;

- (void)loadProductsWithPage:(NSInteger)page;

@end
