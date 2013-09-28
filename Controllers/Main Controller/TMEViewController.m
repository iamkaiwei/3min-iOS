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
    
    self.viewControllers = @[browserVC, publishVC, loginVC, dummy1, dummy2];
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

@end
