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
UICollectionViewDelegate
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) LBDelegateMatrioska *chainDelegate;

@end

@implementation TMEFollowingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = (id) self.chainDelegate;
    [self enablePullToRefresh];
}

- (LBDelegateMatrioska *)chainDelegate {
    if (!_chainDelegate) {
        _chainDelegate = [[LBDelegateMatrioska alloc] initWithDelegates:@[self.collectionView.delegate, self]];
    }

    return _chainDelegate;
}

- (id<KHCollectionViewCellFactoryProtocol>)cellFactory {
    TMEFollowingCellFactory *cellFactory = [[TMEFollowingCellFactory alloc] init];
    return cellFactory;
}

- (id<KHTableViewSectionModel>)getLoadingContentViewModel {
    return [[KHOrderedDataProvider alloc] init];
}

- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel forPage:(NSUInteger)page {
	return [[TMEFollowingLoadingOperation alloc] initUserID:[self.user.userID integerValue] page:page + 1];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TMEUser *user = (TMEUser *)[self itemAtIndexPath:indexPath];
}

@end
