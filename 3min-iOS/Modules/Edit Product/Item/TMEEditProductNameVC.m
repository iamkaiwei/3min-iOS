//
//  TMEEditProductNameVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/18/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEEditProductNameVC.h"
#import <CoreLocation/CoreLocation.h>
#import <SZTextView.h>
#import "TMEEditProductLocationVC.h"

@interface TMEEditProductNameVC () <UITextFieldDelegate, UITextViewDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet SZTextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (nonatomic, strong) UITapGestureRecognizer *tapGR;

@end

@implementation TMEEditProductNameVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigationItems];
    [self setupTableView];
    [self setupGR];

    self.descriptionTextView.placeholder = @"Product description";
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

- (void)dealloc
{
    [self.view removeGestureRecognizer:self.tapGR];
}


#pragma mark - Setup
- (void)setupNavigationItems
{
    self.title = @"Description";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem cancelItemWithTarget:self action:@selector(cancelTouched:)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem doneItemWithTarget:self action:@selector(doneTouched:)];
}

- (void)setupTableView
{
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)setupGR
{
    self.tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    self.tapGR.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:self.tapGR];
}

- (void)displayProduct
{
    self.nameTextField.text = self.product.name;
    self.descriptionTextView.text = self.product.productDescription;
    self.locationTextField.text = self.product.venueName;
}

#pragma mark - Action
- (void)viewTapped:(id)sender
{
    [self.view endEditing:YES];
}

- (void)doneTouched:(id)sender
{
    self.product.name = self.nameTextField.text;
    self.product.productDescription = self.descriptionTextView.text;

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

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }

    return YES;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == 2) {
        TMEEditProductLocationVC *vc = [TMEEditProductLocationVC tme_instantiateFromStoryboardNamed:@"EditProductLocation"];
        vc.product = self.product;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
