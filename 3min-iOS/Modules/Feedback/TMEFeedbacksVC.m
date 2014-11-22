//
//  TMEFeedbacksVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/22/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEFeedbacksVC.h"
#import "TMESingleSectionDataSource.h"
#import "TMEFeedbackCell.h"
#import "TMEFeedback.h"

@interface TMEFeedbacksVC () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, strong) TMESingleSectionDataSource *dataSource;

@end

@implementation TMEFeedbacksVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigationBar];
    [self setupTableView];
    [self requestFeedbacks];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [SVProgressHUD dismiss];
}

#pragma mark - Setup
- (void)setupNavigationBar
{
    self.navigationBar.barTintColor = [UIColor lightGrayColor];
}

- (void)setupTableView
{
    self.tableView.tableFooterView = [[UIView alloc] init];

    self.dataSource = [[TMESingleSectionDataSource alloc] init];
    self.dataSource.cellIdentifier = [TMEFeedbackCell kind];
    self.dataSource.cellConfigureBlock = ^(TMEFeedbackCell *cell, TMEFeedback *feedback) {

    };

    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
}

#pragma mark - Data
- (void)requestFeedbacks
{
    [SVProgressHUD show];
    [TMEFeedbackClient getFeedbacksForUser:self.user success:^(NSArray *array) {
        self.dataSource.items = array;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:nil];
    }];
}

#pragma mark - Action
- (IBAction)cancelTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
