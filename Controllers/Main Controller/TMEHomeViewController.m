//
//  ViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 08/09/13.
//  Copyright (c) 2013 hasBrain. All rights reserved.
//

typedef NS_ENUM(NSInteger, TMETabbarButtonType){
    TMETabbarButtonTypeBrowser  = 0,
    TMETabbarButtonTypeSearch   = 1,
    TMETabbarButtonTypeSell     = 2,
    TMETabbarButtonTypeActivity = 3,
    TMETabbarButtonTypeMe       = 4
};

#import "TMEBrowserCollectionViewController.h"
#import "TMEHomeViewController.h"
#import "TMEPublishProductViewController.h"
#import "TMEBrowserProductsViewController.h"
#import "TMEPhotoButton.h"
#import "AFPhotoEditorController.h"
#import "TMEBrowserProductsViewController.h"
#import "TMEPublishProductViewController.h"
#import "TMELoginViewController.h"
#import "PBImageHelper.h"

@interface TMEHomeViewController ()
<
AFPhotoEditorControllerDelegate,
UITabBarDelegate,
UIImagePickerControllerDelegate
>

@property (nonatomic, strong) TMEBrowserProductsViewController *browser;

@end

@implementation TMEHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Main Menu";
    
    self.viewControllers = @[];
    
    [self addBrowserProductTab];
    [self addDummy1Button];
    [self addPublishButton];
    [self addDummy2Button];
    [self addDummy3Button];
}

#pragma marks - UI helper

- (void)addViewController:(UIViewController *)viewController
              withIconName:(NSString *)iconName
{
    NSMutableArray *VCs = [self.viewControllers mutableCopy];
    
    if (!VCs)
        VCs = [@[] mutableCopy];
    
    [VCs addObject:viewController];
    self.viewControllers = VCs;

    NSInteger index = [self.viewControllers indexOfObject:viewController];
    [self createTabbarButtonWithIconName:iconName atIndex:index];
}

- (void)createTabbarButtonWithIconName:(NSString *)iconName
                             atIndex:(NSInteger)index
{
    UITabBar *tabBar = self.tabBar;
    UITabBarItem *button = [tabBar.items objectAtIndex:index];
    button.imageInsets = UIEdgeInsetsMake(3, 0, -2, 0);
    UIImage *browserBtnBackground = [UIImage imageNamed:iconName];
    [button setFinishedSelectedImage:browserBtnBackground withFinishedUnselectedImage:browserBtnBackground];
}

- (void)addBrowserProductTab
{
    TMEBrowserProductsViewController *browserVC = [[TMEBrowserProductsViewController alloc] init];
//    TMEBrowserCollectionViewController *browserVC = [[TMEBrowserCollectionViewController alloc] init];
    TMENavigationViewController *navigationViewController = [[TMENavigationViewController alloc] initWithRootViewController:browserVC];

    [self addViewController:navigationViewController
               withIconName:@"tabbar-browser-icon"];
}

- (void)addDummy1Button
{
    UIViewController *browserVC = [[UIViewController alloc] init];
    
    [self addViewController:browserVC
               withIconName:@"tabbar-search-icon"];
}

- (void)addDummy2Button
{
    UIViewController *browserVC = [[UIViewController alloc] init];

    [self addViewController:browserVC
               withIconName:@"tabbar-activity-icon"];
}

- (void)addDummy3Button
{
    UIViewController *browserVC = [[UIViewController alloc] init];
    
    [self addViewController:browserVC
               withIconName:@"tabbar-me-icon"];
}

- (void)addPublishButton
{
    TMEPublishProductViewController *publishVC = [[TMEPublishProductViewController alloc] init];
    TMENavigationViewController *navigationViewController = [[TMENavigationViewController alloc] initWithRootViewController:publishVC];
    [self addViewController:navigationViewController
               withIconName:@"tabbar-sell-icon"];
}

#pragma marks - UITabbarViewController delegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSUInteger idx = [tabBar.items indexOfObject:item];
    switch (idx) {
        case TMETabbarButtonTypeSell:{
            [self onBtnSellProduction];
            break;
        }
            
        default:
            break;
    }
}

#pragma marks - UIImagePicker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // close the picker VCs.
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    
    // Add that image to Publish VC
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
}

#pragma marks - Action when click on sell product
- (void)onBtnSellProduction
{
    TMENavigationViewController *navVC =[self.viewControllers objectAtIndex:TMETabbarButtonTypeSell];
    TMEPublishProductViewController *publishVC = (TMEPublishProductViewController *) [navVC.viewControllers objectAtIndex:0];
    
    // if user still editing a product.
    if([publishVC getStatusEditing])
        return;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = [publishVC getFirstPhotoButton];
    picker.allowsEditing=YES;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Oh Snap" delegate:nil cancelButtonTitle:@"Failed to load the camera." otherButtonTitles:nil];
        [alert show];
    }
    
    [navVC presentViewController:picker animated:NO completion:nil];
}

@end
