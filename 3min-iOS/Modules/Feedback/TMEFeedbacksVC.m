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

@property (nonatomic, strong) TMEFeedbackCell *prototypeCell;

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
        [cell configureForModel:feedback];
    };

    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
}

- (TMEFeedbackCell *)prototypeCell
{
    if (!_prototypeCell) {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:[TMEFeedbackCell kind]];
    }

    return _prototypeCell;
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

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IOS8_OR_ABOVE) {
        return UITableViewAutomaticDimension;
    } else {
        TMEFeedback *feedback = self.dataSource.items[indexPath.row];
        CGFloat height = [self cellHeighFromFeedback:feedback] + 1;
        return height;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    TMEFeedback *feedback = self.dataSource.items[indexPath.row];

    TMEProfilePageContentViewController *vc = [[TMEProfilePageContentViewController alloc] init];
    vc.user = feedback.user;

    // TODO: Weird, how to show the profile screen ?
}

#pragma mark - Helper
- (CGFloat)cellHeighFromFeedback:(TMEFeedback *)feedback
{
    [self.prototypeCell configureForModel:feedback];

    self.prototypeCell.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(self.prototypeCell.bounds));

    [self.prototypeCell setNeedsLayout];
    [self.prototypeCell layoutIfNeeded];

    return [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
}

@end
