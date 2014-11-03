//
//  TMEFollowingViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 2/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEFollowingViewController.h"
#import "TMEFollowingCellFactory.h"
#import "TMEFollowingLoadingOperation.h"
#import <KHTableViewController/KHCollectionController.h>
#import <KHTableViewController/KHContentLoadingSectionViewModel.h>
#import <KHTableViewController/KHOrderedDataProvider.h>


@interface TMEFollowingViewController ()

@end

@implementation TMEFollowingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self enablePullToRefresh];
}

- (id<KHCollectionViewCellFactoryProtocol>)cellFactory {
    return [[TMEFollowingCellFactory alloc] init];
}

- (id<KHTableViewSectionModel>)getLoadingContentViewModel {
    return [[KHOrderedDataProvider alloc] init];
}

- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel forPage:(NSUInteger)page {
	return [[TMEFollowingLoadingOperation alloc] initUserID:[self.user.userID integerValue] page:page + 1];
}

@end
