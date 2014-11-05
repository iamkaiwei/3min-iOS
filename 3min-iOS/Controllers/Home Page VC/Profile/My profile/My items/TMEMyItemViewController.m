//
//  TMEMyItemViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 5/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEMyItemViewController.h"
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>
#import <KHTableViewController/KHCollectionController.h>
#import <LBDelegateMatrioska/LBDelegateMatrioska.h>
#import <KHTableViewController/KHContentLoadingCellFactory.h>
#import <KHTableViewController/KHOrderedDataProvider.h>
#import "TMEMyItemLoadingOperation.h"
#import "TMEBrowserProductCellFactory.h"

@interface TMEMyItemViewController ()
<
    UICollectionViewDelegateFlowLayout,
    TMEProductCollectionViewCellDelegate,
    KHBasicOrderedCollectionViewControllerProtocol
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation TMEMyItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self enablePullToRefresh];
    [[FLEXManager sharedManager] showExplorer];
}

- (UICollectionView *)collectionView {
    return _collectionView;
}

- (id <KHCollectionViewCellFactoryProtocol> )cellFactory {
	TMEBrowserProductCellFactory *cellFactory = [[TMEBrowserProductCellFactory alloc] init];
	cellFactory.delegate = self;
	return cellFactory;
}

- (UICollectionViewLayout *)getCollectionViewLayout {
	CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
	layout.columnCount = 2;
	layout.minimumColumnSpacing = 5;
	layout.minimumInteritemSpacing = 6;
    return layout;
}

- (id <KHTableViewSectionModel> )getLoadingContentViewModel {
	return [[KHOrderedDataProvider alloc] init];
}

- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel forPage:(NSUInteger)page {
    return [[TMEMyItemLoadingOperation alloc] initWithPage:page+1];
}

#pragma mark - Collection delegate

- (void)tapOnDetailsProductOnCell:(TMEProductCollectionViewCell *)cell {
	NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
	TMEProduct *product = (TMEProduct *)[self itemAtIndexPath:indexPath];
	ProductCollectionCellAct(self, product, TMEProductCollectionCellGoDetails);
}

- (void)tapOnLikeProductOnCell:(TMEProductCollectionViewCell *)cell {
	NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
	TMEProduct *product = (TMEProduct *)[self itemAtIndexPath:indexPath];
	ProductCollectionCellAct(self, product, TMEProductCollectionCellLike);
}

- (void)tapOnCommentProductOnCell:(TMEProductCollectionViewCell *)cell {
	NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
	TMEProduct *product = (TMEProduct *)[self itemAtIndexPath:indexPath];
	ProductCollectionCellAct(self, product, TMEProductCollectionCellComment);
}

- (void)tapOnShareProductOnCell:(TMEProductCollectionViewCell *)cell {
	NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
	TMEProduct *product = (TMEProduct *)[self itemAtIndexPath:indexPath];
	ProductCollectionCellAct(self, product, TMEProductCollectionCellShare);
}

- (void)tapOnViewProfileOnProductOnCell:(TMEProductCollectionViewCell *)cell {
	NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
	TMEProduct *product = (TMEProduct *)[self itemAtIndexPath:indexPath];
	ProductCollectionCellAct(self, product, TMEProductCollectionCellViewProfile);
}

@end
