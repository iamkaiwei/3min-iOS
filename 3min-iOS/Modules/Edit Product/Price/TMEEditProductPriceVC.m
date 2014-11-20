//
//  TMEEditProductPriceVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/18/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEEditProductPriceVC.h"

@interface TMEEditProductPriceVC () <UITextFieldDelegate, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;

@end

@implementation TMEEditProductPriceVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigationItems];
    [self setupTableView];
    [self displayProduct];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup
- (void)setupNavigationItems
{
    self.title = @"Price";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem cancelItemWithTarget:self action:@selector(cancelTouched:)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem doneItemWithTarget:self action:@selector(doneTouched:)];
}

- (void)setupTableView
{
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)displayProduct
{
    self.priceTextField.text = self.product.price;
}

#pragma mark - Action
- (void)doneTouched:(id)sender
{
    self.product.price = self.priceTextField.text;

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}


@end
