//
//  TMEBasePhotoEditorViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 12/9/13.
//
//

#import "TMEBasePhotoEditorViewController.h"

@interface TMEBasePhotoEditorViewController ()

@end

@implementation TMEBasePhotoEditorViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

@end
