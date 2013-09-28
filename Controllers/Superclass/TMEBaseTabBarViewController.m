//
//  TMEBaseTabBarViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 28/9/13.
//
//

#import "TMEBaseTabBarViewController.h"

@interface TMEBaseTabBarViewController ()

@end

@implementation TMEBaseTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self addNavigationItems];
}

#pragma marks - Some VC stuffs
- (void)addNavigationItems
{
    // Nav left button
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (self == [[self.navigationController viewControllers] objectAtIndex:0]) {
        [leftButton setImage:[UIImage imageNamed:@"category-list-icon"] forState:UIControlStateNormal];
        [leftButton addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [leftButton setImage:[UIImage imageNamed:@"category-list-icon"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(onBtnBack) forControlEvents:UIControlEventTouchUpInside];
    }
    
    leftButton.frame = CGRectMake(0, 0, 40, 30);
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    // Nav right button
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"grid-view-icon"] forState:UIControlStateNormal];
    [rightButton addTarget:self.viewDeckController action:@selector(toggleRightView) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(0, 0, 40, 30);
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)onBtnBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)trackCritercismBreadCrumb:(NSUInteger)lineNumber
{
    NSString *breadcrumb = [NSString stringWithFormat:@"%@:%d", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], lineNumber];
    [Crittercism leaveBreadcrumb:breadcrumb];
}

@end
