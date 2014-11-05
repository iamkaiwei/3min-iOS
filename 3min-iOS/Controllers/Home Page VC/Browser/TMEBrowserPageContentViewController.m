//
//  TMEBrowserPageContentViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEBrowserPageContentViewController.h"
#import "TMEProductCollectionViewCell.h"
#import "TMEBrowserProductViewModel.h"
#import "TMELoadMoreCollectionFooterView.h"
#import "TMEDropDownMenuViewController.h"
#import "UIView+TitleViewUtils.h"
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>
#import <KHTableViewController/KHCollectionController.h>
#import <LBDelegateMatrioska/LBDelegateMatrioska.h>
#import <KHTableViewController/KHContentLoadingCellFactory.h>
#import <KHTableViewController/KHOrderedDataProvider.h>
#import "TMEBrowserProductLoadingOperation.h"
#import "TMEBrowserProductCellFactory.h"

@interface TMEBrowserPageContentViewController ()
<
    UICollectionViewDelegateFlowLayout,
    TMEProductCollectionViewCellDelegate,
    KHBasicOrderedCollectionViewControllerProtocol
>

@end

@implementation TMEBrowserPageContentViewController

#pragma mark - VC cycle

- (void)viewDidLoad {
	[super viewDidLoad];

	// Do any additional setup after loading the view from its nib.

	[self listenToTheCategoryDidChangedNofitication];
    [self enablePullToRefresh];
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
	return [[TMEBrowserProductLoadingOperation alloc] initWithCategory:self.currentCategory andPage:page + 1];
}

#pragma mark -

- (void)listenToTheCategoryDidChangedNofitication {
	__weak typeof(self) weakSelf = self;

	[[NSNotificationCenter defaultCenter] addObserverForName:TMEHomeCategoryDidChangedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock: ^(NSNotification *note) {
	    TMEDropDownMenuViewController *vc = note.object;
	    weakSelf.currentCategory = vc.selectedCategory;
	    UIButton *centerBtn = [weakSelf.parentViewController.navigationItem.titleView getButton];
	    [centerBtn setTitle:weakSelf.currentCategory.name forState:UIControlStateNormal];
	    [centerBtn setTitle:weakSelf.currentCategory.name forState:UIControlStateSelected];

	    [self reloadAlData];
	}];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Reload

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
