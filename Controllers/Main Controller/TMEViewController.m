//
//  ViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 08/09/13.
//  Copyright (c) 2013 hasBrain. All rights reserved.
//

#import "TMEViewController.h"
#import "TMEPublishProductViewController.h"
#import "TMEPhotoButton.h"
#import "AFPhotoEditorController.h"
#import "PBImageHelper.h"

@interface TMEViewController () <AFPhotoEditorControllerDelegate>

@end

@implementation TMEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Main Menu";
}

#pragma mark - Link to product config

- (IBAction)onBtnTakePictures:(id)sender {
    TMEPublishProductViewController *publishVC = [[TMEPublishProductViewController alloc] init];
    [self.navigationController pushViewController:publishVC animated:YES];
}

@end
