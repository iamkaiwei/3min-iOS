//
//  ViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 08/09/13.
//  Copyright (c) 2013 hasBrain. All rights reserved.
//

#import "TMEViewController.h"
#import "TMEPublishProductViewController.h"
#import "TMEBrowserProductsViewController.h"
#import "TMEPhotoButton.h"
#import "AFPhotoEditorController.h"
#import "TMEBrowserProductsViewController.h"
#import "TMEPublishProductViewController.h"
#import "TMELoginViewController.h"
#import "PBImageHelper.h"

@interface TMEViewController () <AFPhotoEditorControllerDelegate>

@property (nonatomic, strong) TMEBrowserProductsViewController *browser;

@end

@implementation TMEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Main Menu";
    
    TMEBrowserProductsViewController *browserVC = [[TMEBrowserProductsViewController alloc] init];
    TMEPublishProductViewController *publishVC = [[TMEPublishProductViewController alloc] init];
    TMELoginViewController *loginVC = [[TMELoginViewController alloc] init];
    
    // dummy VCs
    TMEBrowserProductsViewController *dummy1 = [[TMEBrowserProductsViewController alloc] init];
    TMEBrowserProductsViewController *dummy2 = [[TMEBrowserProductsViewController alloc] init];
    
    self.viewControllers = @[browserVC, dummy1, publishVC, loginVC, dummy2];
    
    [self stypeTheTabbarButtons];
}

#pragma mark - Link to product config

- (IBAction)onBtnTakePictures:(id)sender {
    TMEPublishProductViewController *publishVC = [[TMEPublishProductViewController alloc] init];
    [self.navigationController pushViewController:publishVC animated:YES];
}

- (IBAction)onBtnBrowserProducts:(id)sender {
    self.browser = [[TMEBrowserProductsViewController alloc] init];
    [self.navigationController pushViewController:self.browser animated:YES];
}
- (IBAction)onBtnShowFBPage:(id)sender {
    TMELoginViewController *loginVC = [[TMELoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}


#pragma marks - UI helper
- (void)stypeTheTabbarButtons{
    UITabBar *tabBar = self.tabBar;
    // browser button
    UITabBarItem *browserBtn = [tabBar.items objectAtIndex:0];
    browserBtn.imageInsets = UIEdgeInsetsMake(3, 0, -2, 0);
    browserBtn.title = @"";
    UIImage *browserBtnBackground = [UIImage imageNamed:@"tabbar-browser-icon"];
    [browserBtn setFinishedSelectedImage:browserBtnBackground withFinishedUnselectedImage:browserBtnBackground];
    
    // search dummy button
    UITabBarItem *dummy1Btn = [tabBar.items objectAtIndex:1];
    dummy1Btn.imageInsets = UIEdgeInsetsMake(3, 0, -2, 0);
    dummy1Btn.title = @"";
    UIImage *dummy1BtnBtnBackground = [UIImage imageNamed:@"tabbar-search-icon"];
    [dummy1Btn setFinishedSelectedImage:dummy1BtnBtnBackground withFinishedUnselectedImage:dummy1BtnBtnBackground];
    
    // publish button
    UITabBarItem *publishBtn = [tabBar.items objectAtIndex:2];
    publishBtn.imageInsets = UIEdgeInsetsMake(3, 0, -2, 0);
    publishBtn.title = @"";
    UIImage *publish1BtnBackground = [UIImage imageNamed:@"tabbar-sell-icon"];
    [publishBtn setFinishedSelectedImage:publish1BtnBackground withFinishedUnselectedImage:publish1BtnBackground];
    
    // login button
    UITabBarItem *loginBtn = [tabBar.items objectAtIndex:3];
    loginBtn.imageInsets = UIEdgeInsetsMake(3, 0, -2, 0);
    loginBtn.title = @"";
    UIImage *loginBtnBackground = [UIImage imageNamed:@"tabbar-activity-icon"];
    [loginBtn setFinishedSelectedImage:loginBtnBackground withFinishedUnselectedImage:loginBtnBackground];
    
    // me button
    UITabBarItem *dummy2Btn = [tabBar.items objectAtIndex:4];
    dummy2Btn.imageInsets = UIEdgeInsetsMake(3, 0, -2, 0);
    dummy2Btn.title = @"";
    UIImage *dummy2BtnBackground = [UIImage imageNamed:@"tabbar-me-icon"];
    [dummy2Btn setFinishedSelectedImage:dummy2BtnBackground withFinishedUnselectedImage:dummy2BtnBackground];
}

@end
