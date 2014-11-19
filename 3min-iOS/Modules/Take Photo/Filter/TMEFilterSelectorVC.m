//
//  TMEFilterSelectorVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/19/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEFilterSelectorVC.h"
#import "TMESingleSectionDataSource.h"
#import "TMEFilterCell.h"

@interface TMEFilterSelectorVC ()

@property (nonatomic, strong) TMESingleSectionDataSource *dataSource;

@end

@implementation TMEFilterSelectorVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup
- (void)setupCollectionView
{
    self.dataSource = [[TMESingleSectionDataSource alloc] init];
    self.dataSource.cellIdentifier = [TMEFilterCell kind];
    self.dataSource.cellConfigureBlock = ^(TMEFilterCell *cell, id object) {

    };

    self.collectionView.dataSource = self.dataSource;
}

#pragma mark - Configure

#pragma mark - Delegate
- (void)didSelectFilter
{
    if ([self.delegate respondsToSelector:@selector(filterSelectorVCDidSelectFilter)]) {
        [self.delegate filterSelectorVCDidSelectFilter];
    }
}

@end
