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
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self addRightButton];
    
    [self switchContainerViewControllerToViewController:self.normalViewController];
}

- (UIBarButtonItem *)rightButton
{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self
                                                                                 action:@selector(onBtnChangeType)];
    return rightButton;
    
}

- (void)addRightButton{
    self.navigationItem.rightBarButtonItem = [self rightButton];
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
}

- (void)onBtnChangeType
{
    if ([self.currentViewController isEqual:self.normalViewController]) {
        [self switchContainerViewControllerToViewController:self.gridViewController];
        return;
    }
    
    [self switchContainerViewControllerToViewController:self.normalViewController];
    return;
}

@end
