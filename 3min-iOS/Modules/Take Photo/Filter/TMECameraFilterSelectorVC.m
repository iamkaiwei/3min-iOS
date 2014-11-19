//
//  TMECameraFilterSelectorVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/19/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMECameraFilterSelectorVC.h"
#import "TMESingleSectionDataSource.h"
#import "TMECameraFilterCell.h"

@interface TMECameraFilterSelectorVC ()

@property (nonatomic, strong) TMESingleSectionDataSource *dataSource;
@property (nonatomic, strong) NSArray *filters;

@end

@implementation TMECameraFilterSelectorVC

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
    self.dataSource.cellIdentifier = [TMECameraFilterCell kind];
    self.dataSource.cellConfigureBlock = ^(TMECameraFilterCell *cell, id object) {

    };

    self.collectionView.dataSource = self.dataSource;
}

#pragma mark - Configure
- (void)configure
{

}

#pragma mark - Delegate
- (void)didSelectFilter
{
    if ([self.delegate respondsToSelector:@selector(filterSelectorVCDidSelectFilter)]) {
        [self.delegate filterSelectorVCDidSelectFilter];
    }
}

#pragma mark - Filter


@end
