//
//  TMEUserItemsViewController.m
//  ThreeMin
//
//  Created by Vinh Nguyen on 22/12/2014.
//  Copyright (c) Năm 2014 3min. All rights reserved.
//

#import "TMEUserItemsViewController.h"
#import <KHTableViewController/KHCollectionController.h>
#import <KHTableViewController/KHContentLoadingCellFactory.h>
#import <KHTableViewController/KHOrderedDataProvider.h>
#import "TMEUserItemsLoadingOperation.h"
#import "TMEBrowserProductCellFactory.h"

@interface TMEUserItemsViewController ()
<
UICollectionViewDelegateFlowLayout,
TMEProductCollectionViewCellDelegate,
KHBasicOrderedCollectionViewControllerProtocol
>

@end

@implementation TMEUserItemsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self enablePullToRefresh];
}

- (id <KHCollectionViewCellFactoryProtocol> )cellFactory
{
    TMEBrowserProductCellFactory *cellFactory = [[TMEBrowserProductCellFactory alloc] init];
    cellFactory.delegate = self;
    return cellFactory;
}

- (UICollectionViewLayout *)getCollectionViewLayout
{
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.columnCount = 2;
    layout.minimumColumnSpacing = 5;
    layout.minimumInteritemSpacing = 6;
    return layout;
}

- (id <KHTableViewSectionModel> )getLoadingContentViewModel
{
    return [[KHOrderedDataProvider alloc] init];
}

- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel forPage:(NSUInteger)page
{
    return [[TMEUserItemsLoadingOperation alloc] initWithUserID:[self.userID unsignedIntegerValue] page:page + 1];
}

#pragma mark - Collection delegate

- (void)tapOnDetailsProductOnCell:(TMEProductCollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    TMEProduct *product = (TMEProduct *)[self itemAtIndexPath:indexPath];
    ProductCollectionCellAct(self, product, TMEProductCollectionCellGoDetails);
}

- (void)tapOnLikeProductOnCell:(TMEProductCollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    TMEProduct *product = (TMEProduct *)[self itemAtIndexPath:indexPath];
    ProductCollectionCellAct(self, product, TMEProductCollectionCellLike);
}

- (void)tapOnCommentProductOnCell:(TMEProductCollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    TMEProduct *product = (TMEProduct *)[self itemAtIndexPath:indexPath];
    ProductCollectionCellAct(self, product, TMEProductCollectionCellComment);
}

- (void)tapOnShareProductOnCell:(TMEProductCollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    TMEProduct *product = (TMEProduct *)[self itemAtIndexPath:indexPath];
    ProductCollectionCellAct(self, product, TMEProductCollectionCellShare);
}

- (void)tapOnViewProfileOnProductOnCell:(TMEProductCollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    TMEProduct *product = (TMEProduct *)[self itemAtIndexPath:indexPath];
    ProductCollectionCellAct(self, product, TMEProductCollectionCellViewProfile);
}

@end
