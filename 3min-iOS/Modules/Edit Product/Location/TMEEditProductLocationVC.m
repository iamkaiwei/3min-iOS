//
//  TMEEditProductLocationVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/18/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEEditProductLocationVC.h"
#import "TMESingleSectionDataSource.h"

@interface TMEEditProductLocationVC () <UITextFieldDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) TMESingleSectionDataSource *dataSource;

@end

@implementation TMEEditProductLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigationItems];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavigationItems
{
    self.title = @"Location";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem cancelItemWithTarget:self action:@selector(cancelTouched:)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem doneItemWithTarget:self action:@selector(doneTouched:)];
}

#pragma mark - Setup
- (void)setupTableView
{
    self.tableView.delegate = self;

    self.dataSource = [[TMESingleSectionDataSource alloc] init];
    self.dataSource.cellIdentifier = [UITableViewCell kind];
    self.dataSource.cellConfigureBlock = ^(UITableViewCell *cell, id object) {

    };

    self.tableView.dataSource = self.dataSource;

    self.tableView.hidden = YES;
}

#pragma mark - Action
- (void)doneTouched:(id)sender
{
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

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
