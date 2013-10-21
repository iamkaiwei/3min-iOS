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

#define ANIMATION_DURATION 0.3

typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;

@interface HTKContainerViewController ()

@property (strong, nonatomic) UIViewController *currentViewController;

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
	// Do any additional setup after loading the view
    [self addNavigationRightButton];
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
}

- (void)assignFullScreenScrollViewWithViewController:(UIViewController *)viewController
{
    UIScrollView *scrollView = [self getScrollViewOfViewController:viewController];
    scrollView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    
    if (self.fullScreenScroll)
    {
        [self.fullScreenScroll setScrollView:scrollView];
        return;
    }
    
    self.fullScreenScroll = [[YIFullScreenScroll alloc] initWithViewController:self
                                                                    scrollView:scrollView];
    self.fullScreenScroll.shouldShowUIBarsOnScrollUp = YES;
    return;
}

#pragma mark - Navigation button
- (UIBarButtonItem *)rightNavigationButton{
    // Nav right button
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"grid-view-icon"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(onBtnGridView:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(0, 0, 40, 30);
    
    return [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)addNavigationRightButton
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

@end
