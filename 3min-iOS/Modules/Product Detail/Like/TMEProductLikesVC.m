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

- (void)awakeFromNib
{
    self.title = @"Likes";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
- (void)setupTableView
{
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
    [self.viewModelKVOController observe:self.view
                                 keyPath:@"users"
                                 options:NSKeyValueObservingOptionNew
                                   block:^(id observer, id object, NSDictionary *change)
     {
         typeof(self) innerSelf = observer;
         [innerSelf.tableView reloadData];
     }];

    [self.viewModel pullUsers];
}

@end