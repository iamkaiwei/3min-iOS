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
#import "TMEFollowingCollectionViewCell.h"
#import <KHTableViewController/KHCollectionController.h>
#import <KHTableViewController/KHContentLoadingSectionViewModel.h>
#import <KHTableViewController/KHOrderedDataProvider.h>


@interface TMEFollowingViewController ()
<
TMEFollowingCollectionViewCellProtocol
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation TMEFollowingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self enablePullToRefresh];
}

- (id<KHCollectionViewCellFactoryProtocol>)cellFactory {
    TMEFollowingCellFactory *cellFactory = [[TMEFollowingCellFactory alloc] init];
    cellFactory.cellDelegate = self;
    return cellFactory;
}

- (id<KHTableViewSectionModel>)getLoadingContentViewModel {
    return [[KHOrderedDataProvider alloc] init];
}

- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel forPage:(NSUInteger)page {
	return [[TMEFollowingLoadingOperation alloc] initUserID:[self.user.userID integerValue] page:page + 1];
}

- (void)onFollowButton:(id)sender {
    UICollectionViewCell *cell = (UICollectionViewCell *)sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];

    TMEUser *user = (TMEUser *)[self itemAtIndexPath:indexPath];
}

@end
