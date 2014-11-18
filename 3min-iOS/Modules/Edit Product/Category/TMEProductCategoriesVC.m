//
//  TMEProductCategoriesVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/18/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductCategoriesVC.h"
#import "TMESingleSectionDataSource.h"
#import "TMEProductCategoryCell.h"

@interface TMEProductCategoriesVC () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) TMESingleSectionDataSource *dataSource;

@end

@implementation TMEProductCategoriesVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableView];
    [self setupNavigationItems];

    [SVProgressHUD show];
    [[TMECategoryManager sharedManager] getAllCategoriesWithSuccess:^(NSArray *models) {
        self.dataSource.items = models;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup
- (void)setupTableView
{
    self.dataSource = [[TMESingleSectionDataSource alloc] init];
    self.dataSource.cellIdentifier = [TMEProductCategoryCell kind];

    __weak typeof (self) weakSelf = self;
    self.dataSource.cellConfigureBlock = ^(TMEProductCategoryCell *cell, TMECategory *category) {
        [cell.categoryImageView setImageWithURL:[NSURL URLWithString:category.image.urlString]];
        cell.categoryLabel.text = category.name;

        if ([weakSelf.product.category.name isEqualToString:category.name]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    };

    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;

    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)setupNavigationItems
{
    self.title = @"Categories";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem cancelItemWithTarget:self action:@selector(cancelTouched:)];
}

#pragma mark - Action
- (void)cancelTouched:(id)sender
{
     [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    TMECategory *category = self.dataSource.items[indexPath.row];
    self.product.category = category;

    [self.tableView reloadData];

    [self.navigationController popViewControllerAnimated:YES];
}

@end
