//
//  HTKContainerViewController.m
//  UIContainerViewController
//
//  Created by Triệu Khang on 14/10/13.
//  Copyright (c) 2013 Triệu Khang. All rights reserved.
//

#import "HTKContainerViewController.h"
#import "TMEBrowserCollectionViewController.h"
#import "TMEBrowserProductsViewController.h"
#import "YIFullScreenScroll.h"

@interface HTKContainerViewController ()
<YIFullScreenScrollDelegate>

@property (strong, nonatomic) TMEBrowserProductsViewController *normalViewController;
@property (strong, nonatomic) TMEBrowserCollectionViewController *gridViewController;

@end

@implementation HTKContainerViewController

- (UIViewController *)normalViewController
{
    if (!_normalViewController) {
        _normalViewController = [[TMEBrowserProductsViewController alloc] init];
    }
    
    return _normalViewController;
}

- (UIViewController *)gridViewController
{
    if (!_gridViewController) {
        _gridViewController = [[TMEBrowserCollectionViewController alloc] init];
    }
    
    return _gridViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e4e2e1"];
    [self switchContainerViewControllerToViewController:self.normalViewController];
}

- (void)switchContainerViewControllerToViewController:(UIViewController *)viewController
{
    [self.currentViewController willMoveToParentViewController:nil];
    [self addChildViewController:viewController];
    viewController.view.frame = self.view.frame;
    [self.view addSubview:viewController.view];
    [self.currentViewController.view removeFromSuperview];
    [self.currentViewController removeFromParentViewController];
    [self.currentViewController didMoveToParentViewController:nil];
    [viewController didMoveToParentViewController:self];
    self.currentViewController = viewController;
 
    [self assignFullScreenScrollViewWithViewController:viewController];
    [self configNavigationRightButton];
}

- (void)assignFullScreenScrollViewWithViewController:(UIViewController *)viewController
{
    UIScrollView *scrollView = [self getScrollViewOfViewController:viewController];
    
    if (self.fullScreenScroll)
    {
        [self.fullScreenScroll setScrollView:scrollView];
        return;
    }
    
    self.fullScreenScroll = [[YIFullScreenScroll alloc] initWithViewController:self
                                                                    scrollView:scrollView
                                                                         style:YIFullScreenScrollStyleFacebook];
    self.fullScreenScroll.delegate = self;
    return;
}

#pragma mark - Navigation button
- (UIBarButtonItem *)rightNavigationButton{
    // Nav right button
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *rightButtonImageName = ([self.currentViewController isEqual:self.normalViewController] ? @"grid-view-icon" : @"simple-view-icon");
    [rightButton setImage:[UIImage imageNamed:rightButtonImageName] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(onBtnGridView:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(0, 0, 40, 30);
    [rightButton adjustNavigationBarButtonDependSystem];
    return [[UIBarButtonItem alloc] initWithCustomView:rightButton];;
}

- (void)configNavigationRightButton
{
    UIBarButtonItem *rightButtonItem = [self rightNavigationButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)onBtnGridView:(id)sender
{
    if ([self.currentViewController isEqual:self.normalViewController]) {
        [self switchContainerViewControllerToViewController:self.gridViewController];
        return;
    }
    
    [self switchContainerViewControllerToViewController:self.normalViewController];
    return;
}

#pragma mark - Utilities
- (UIScrollView *)getScrollViewOfViewController:(UIViewController *)viewController
{
    for (UIView *view in [viewController.view subviews]) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            return (UIScrollView *)view;
        }
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            return (UIScrollView *)view;
        }
    }
    
    return nil;
}

- (UIScrollView *)getScrollView
{
    return [self getScrollViewOfViewController:self.currentViewController];
}

- (void)fullScreenScrollDidLayoutUIBars:(YIFullScreenScroll *)fullScreenScroll{
  if([self.currentViewController respondsToSelector:@selector(fullScreenScrollDidLayoutUIBars:)]){
    [self.currentViewController performSelector:@selector(fullScreenScrollDidLayoutUIBars:) withObject:fullScreenScroll];
  }
}

@end
