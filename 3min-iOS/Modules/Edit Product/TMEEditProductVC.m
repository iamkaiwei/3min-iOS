//
//  TMEEditProductVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/18/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEEditProductVC.h"

typedef NS_ENUM(NSUInteger, TMEProductRow) {
    TMEProductRowPhoto,
    TMEProductRowCategory,
    TMEProductRowItem,
    TMEProductRowPrice,
    TMEProductRowFacebook,
    TMEProductRowDeleteListing,
    TMEProductRowCount,
};

@interface TMEEditProductVC ()

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UISwitch *facebookSwitch;
@property (nonatomic, assign) BOOL isCreatedNew;


@end

@implementation TMEEditProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItems];

    if (self.product) {
        self.title = self.product.name;
        [self displayProduct];
    } else {
        self.title = @"Start Selling";
        self.isCreatedNew = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup
- (void)setupNavigationItems
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage originalImageNamed:@"icn_cancel"] style:UIBarButtonItemStylePlain target:self action:@selector(cancelTouched:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage originalImageNamed:@"icn_submit"] style:UIBarButtonItemStylePlain target:self action:@selector(submitTouched:)];
}

- (void)displayProduct
{
    self.categoryLabel.text = self.product.category.name;
    self.itemLabel.text = self.product.name;
    self.priceLabel.text = self.product.price;
}

#pragma mark - Action
- (void)cancelTouched:(id)sender
{

}

- (void)submitTouched:(id)sender
{

}

- (IBAction)deleteListingTouched:(id)sender
{

}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isCreatedNew && indexPath.row == TMEProductRowDeleteListing) {
        return 0;
    }

    if (!self.isCreatedNew && indexPath.row == TMEProductRowFacebook) {
        return 0;
    }

    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
