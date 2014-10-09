//
//  TMEProductLikesVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 9/22/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductLikesVC.h"
#import "TMEProductLikeCell.h"
#import "TMEProductLikeViewModel.h"
#import "TMESingleSectionDataSource.h"

@interface TMEProductLikesVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) TMEProductLikeViewModel *viewModel;
@property (nonatomic, strong) FBKVOController *viewModelKVOController;
@property (nonatomic, strong) TMESingleSectionDataSource *dataSource;

@end

@implementation TMEProductLikesVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *formatString = self.product.likeCount > 1 ? @"%d Likes" : @"%d Like";
    self.title = NSStringf(formatString, self.product.likeCount);

    [self setupTableView];
    [self configureViewModel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
- (void)setupTableView
{
    self.tableView.tableFooterView = [[UIView alloc] init];

    // DataSource
    self.dataSource = [[TMESingleSectionDataSource alloc] init];
    self.dataSource.cellIdentifier = [TMEProductLikeCell kind];
    self.dataSource.cellConfigureBlock = ^(TMEProductLikeCell *cell, TMEUser *user) {
        [cell configureForModel:user];
    };

    self.dataSource.actionBlock = ^(TMEUser *user) {

    };

    self.tableView.delegate = self.dataSource;
    self.tableView.dataSource = self.dataSource;
}

#pragma mark - ViewModel
- (void)configureViewModel
{
    self.viewModel = [[TMEProductLikeViewModel alloc] initWithProduct:self.product];
    self.viewModelKVOController = [FBKVOController controllerWithObserver:self];
    [self.viewModelKVOController observe:self.viewModel
                                 keyPath:@"users"
                                 options:NSKeyValueObservingOptionNew
                                   block:^(id observer, id object, NSDictionary *change)
     {
         [SVProgressHUD dismiss];
         typeof(self) innerSelf = observer;
         innerSelf.dataSource.items = innerSelf.viewModel.users;
         [innerSelf.tableView reloadData];
     }];

    [SVProgressHUD show];
    [self.viewModel pullUsers];
}

@end
