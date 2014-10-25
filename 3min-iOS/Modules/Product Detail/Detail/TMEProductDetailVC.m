//
//  TMEProductDetailVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 9/22/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductDetailVC.h"
#import "TMEProduct.h"
#import "TMEOfferViewController.h"
#import "TMEProductDetailOnlyTableVC.h"
#import "UIViewController+Additions.h"

@interface TMEProductDetailVC ()

@property (weak, nonatomic) IBOutlet UIButton *chatToBuyButton;
@property (nonatomic, strong) TMEProductDetailOnlyTableVC *productDetailOnlyTableVC;

@end

@implementation TMEProductDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupChildVC];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup
- (void)setupChildVC
{
    // Product Detail Only
    self.productDetailOnlyTableVC = [TMEProductDetailOnlyTableVC
                                      tme_instantiateFromStoryboardNamed:@"ProductDetail"];
    self.productDetailOnlyTableVC.product = self.product;
    [self addChildVC:self.productDetailOnlyTableVC containerView:self.view];
    [self.view sendSubviewToBack:self.productDetailOnlyTableVC.view];
}

#pragma mark - Product
- (void)setProduct:(TMEProduct *)product
{
    _product = product;

    self.title = product.name;
}

#pragma mark - Action
- (IBAction)chatToBuyButtonTouched:(id)sender {
    TMEOfferViewController *offerController = [[TMEOfferViewController alloc] init];
    offerController.product = self.product;
//    offerController.conversation = self.conversation;
    [self.navigationController pushViewController:offerController animated:YES];
}


@end
