//
//  TMENavigationViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 27/9/13.
//
//

#import "TMENavigationViewController.h"

@interface TMENavigationViewController ()

@end

@implementation TMENavigationViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//        self.navigationBar.tintColor = [UIColor colorWithHexString:@"e4e2e1"];
//        self.navigationBar.clipsToBounds = YES;
//        [[UINavigationBar appearance] setTitleTextAttributes: @{
//                                                                UITextAttributeTextColor: [UIColor colorWithHexString:@"ff6600"],
//                                                                UITextAttributeTextShadowColor: [UIColor clearColor],
//                                                                UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 0.0f)],
//                                                                UITextAttributeFont: [UIFont fontWithName:@"Helvetica" size:20.0f]
//                                                                }];
//        self.navigationBar
//    }
//    return self;
//}

+ (TMENavigationViewController *)navigationController
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TMENavigationViewController" owner:self options:nil];
    TMENavigationViewController *controller = (TMENavigationViewController *)[nib objectAtIndex:0];
    return controller;
}


+ (TMENavigationViewController *)navigationControllerWithRootViewController:(UIViewController *)rootViewController
{
    TMENavigationViewController *controller = [TMENavigationViewController navigationController];
    [controller setViewControllers:[NSArray arrayWithObject:rootViewController]];
    return controller;
}

- (id)init
{
    self = [super init];
    return [TMENavigationViewController navigationController]; // Over-retain, this should be alloced
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super init];
    return [TMENavigationViewController navigationControllerWithRootViewController:rootViewController];
}

@end
