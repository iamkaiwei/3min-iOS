//
//  HTKContainerViewController.m
//  UIContainerViewController
//
//  Created by Triệu Khang on 14/10/13.
//  Copyright (c) 2013 Triệu Khang. All rights reserved.
//

#import "HTKContainerViewController.h"
#import "HTKViewController.h"
#import "HTKViewController2.h"

@interface HTKContainerViewController ()

@property (strong, nonatomic) UIViewController *currentViewController;

@end

@implementation HTKContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self addRightButton];
    
    [self switchContainerViewControllerToViewController:[[HTKViewController2 alloc] init]];
    
    
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
    [self.view addSubview:viewController.view];
    [self.currentViewController.view removeFromSuperview];
    [self.currentViewController removeFromParentViewController];
    [self.currentViewController didMoveToParentViewController:nil];
    
    [viewController didMoveToParentViewController:self];
    
    self.currentViewController = viewController;
}

- (void)onBtnChangeType
{
    if ([self.currentViewController isKindOfClass:[HTKViewController2 class]]) {
        [self switchContainerViewControllerToViewController:[[HTKViewController alloc] init]];
        return;
    }
    
    [self switchContainerViewControllerToViewController:[[HTKViewController2 alloc] init]];
    return;
}

@end
