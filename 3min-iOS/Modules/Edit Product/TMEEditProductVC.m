//
//  TMEEditProductVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/18/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEEditProductVC.h"
#import "TMEProductCategoriesVC.h"
#import "TMEEditProductNameVC.h"
#import "TMEEditProductPriceVC.h"

#import "TMECameraVC.h"

typedef NS_ENUM(NSUInteger, TMEProductRow) {
    TMEProductRowPhoto = 0,
    TMEProductRowCategory,
    TMEProductRowItem,
    TMEProductRowPrice,
    TMEProductRowFacebook,
    TMEProductRowDeleteListing,
    TMEProductRowCount,
};

@interface TMEEditProductVC ()

@property (weak, nonatomic) IBOutlet UITextField *categoryTextField;
@property (weak, nonatomic) IBOutlet UITextField *itemTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UISwitch *facebookSwitch;

@property (nonatomic, assign) BOOL isUpdate;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;

@end

@implementation TMEEditProductVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigationItems];
    [self setupTableView];

    if (self.isUpdate) {
        self.title = self.product.name;
    } else {
        _product = [[TMEProduct alloc] init];
        self.title = @"Start Selling";
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self displayProduct];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data
- (void)setProduct:(TMEProduct *)product
{
    _product = [product copy];
    self.isUpdate = YES;
}

#pragma mark - Setup
- (void)setupTableView
{
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)setupNavigationItems
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem cancelItemWithTarget:self action:@selector(cancelTouched:)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem submitItemWithTarget:self action:@selector(submitTouched:)];
}

- (void)displayProduct
{
    self.categoryTextField.text = self.product.category.name;
    self.itemTextField.text = self.product.name;
    self.priceTextField.text = self.product.price;

    if (!self.isUpdate) {
        NSArray *buttons = [self buttons];
        for (int i=0; i<buttons.count && i<self.product.images.count; ++i) {
            TMEProductImage *productImage = self.product.images[i];
            UIButton *button = buttons[i];
            [button setImageForState:UIControlStateNormal withURL:productImage.originURL];
        }
    }
}

#pragma mark - Action
- (void)cancelTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)submitTouched:(id)sender
{
    if (![self isFormCompleted]) {
        return;
    }

    NSString *message = nil;
    if (self.isUpdate) {
        message = @"Are you sure you want to update this product?";
    } else {
        message = @"Are you sure you want to create this product?";
    }


    [TMEAlertController showMessage:message fromVC:self actionButton:@"OK" handler:^{
        if (self.isUpdate) {
            [self requestToUpdateProduct];
        } else {
            [self requestToCreateProduct];
        }
    }];

}

- (IBAction)deleteListingTouched:(id)sender
{
    [TMEAlertController showMessage:@"Are you sure you want to delete this product?" fromVC:self actionButton:@"OK" handler:^{
        
    }];
}

#pragma mark - Network request
- (void)requestToCreateProduct
{
    [TMEProductsManager createProduct:self.product images:nil success:^(TMEProduct *responsedProduct) {

    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)requestToUpdateProduct
{

}

#pragma mark - Check
- (BOOL)isFormCompleted
{
    // Name
    if (self.itemTextField.text.length == 0) {
        [TMEAlertController showMessage:@"Please input product name" fromVC:self];
        return NO;
    }

    // Category
//    if (self.categoryTextField.text.length == 0) {
//        [TMEAlertController showMessage:@"Please set a category" fromVC:self];
//        return NO;
//    }

    // Price
    if (self.priceTextField.text.length == 0) {
        [TMEAlertController showMessage:@"Please set a price" fromVC:self];
        return NO;
    }

    // Image

    return YES;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];

    if (!IS_IOS8_OR_ABOVE)
    {
        cell.contentView.frame = cell.bounds;
        cell.contentView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    }

    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == TMEProductRowPhoto) {
        return self.view.width;
    }

    if (self.isUpdate && indexPath.row == TMEProductRowFacebook) {
        return 0;
    }

    if (!self.isUpdate && indexPath.row == TMEProductRowDeleteListing) {
        return 0;
    }

    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == TMEProductRowCategory) {
        TMEProductCategoriesVC *vc = [TMEProductCategoriesVC tme_instantiateFromStoryboardNamed:@"ProductCategory"];
        vc.product = self.product;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == TMEProductRowItem) {
        TMEEditProductNameVC *vc = [TMEEditProductNameVC tme_instantiateFromStoryboardNamed:@"EditProductName"];
        vc.product = self.product;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == TMEProductRowPrice) {
        TMEEditProductPriceVC *vc = [TMEEditProductPriceVC tme_instantiateFromStoryboardNamed:@"EditProductPrice"];
        vc.product = self.product;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - Action
- (IBAction)photoButtonTouched:(UIButton *)button
{
    TMECameraVC *cameraVC = [TMECameraVC tme_instantiateFromStoryboardNamed:@"Camera"];

    __weak typeof (self) weakSelf = self;
    cameraVC.completionHandler = ^(TMECameraVCResult result, UIImage *image, IMGLYFilterType filterType) {
        if (result == TMECameraVCResultDone) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, NULL);
        }
        
        [weakSelf.navigationController popToViewController:weakSelf animated:YES];
        [button setImage:image forState:UIControlStateNormal];
    };

    [self.navigationController pushViewController:cameraVC animated:YES];
}

#pragma mark - Helpers
- (NSArray *)buttons
{
    return @[self.button1, self.button2, self.button3, self.button4];
}

@end
