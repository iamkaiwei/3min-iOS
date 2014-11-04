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
    TMEProductCollectionViewCellDelegate
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UIRefreshControl *refreshView;
@property (strong, nonatomic) CHTCollectionViewWaterfallLayout *layout;
@property (strong, nonatomic) TMEBrowserProductViewModel *viewModel;
@property (strong, nonatomic) FBKVOController *kvoController;
@property (strong, nonatomic) LBDelegateMatrioska *chainDelegate;

@property (strong, nonatomic) TMETakePhotoButtonViewController *takePhotoButtonVC;
@property (strong, nonatomic) TMECategory *currentCategory;
@end

@implementation TMEBrowserPageContentViewController

#pragma mark - VC cycle

- (void)viewDidLoad {
	[super viewDidLoad];

	// Do any additional setup after loading the view from its nib.

	[self listenToTheCategoryDidChangedNofitication];
}

- (id<KHCollectionViewCellFactoryProtocol>)cellFactory {
    TMEBrowserProductCellFactory *cellFactory = [[TMEBrowserProductCellFactory alloc] init];
    self.collectionView.collectionViewLayout = [cellFactory waterFlowLayout];
    cellFactory.delegate = self;
    return cellFactory;
}

- (id<KHTableViewSectionModel>)getLoadingContentViewModel {
    return [[KHOrderedDataProvider alloc] init];
}

- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel forPage:(NSUInteger)page {
    return [[TMEBrowserProductLoadingOperation alloc] initWithCategory:self.currentCategory andPage:page+1];
}

#pragma mark -

- (void)addTakePhotoButton {
	self.takePhotoButtonVC = [[TMETakePhotoButtonViewController alloc] init];
	[self.takePhotoButtonVC willMoveToParentViewController:self];
    [self.view addSubview:self.takePhotoButtonVC.view];
	[self.takePhotoButtonVC.view mas_makeConstraints: ^(MASConstraintMaker *make) {
	    make.bottom.equalTo(self.view);
	    make.trailing.equalTo(self.view);
	    make.leading.equalTo(self.view);
	    make.height.equalTo(@70);
	}];

	[self.takePhotoButtonVC didMoveToParentViewController:self];
	[self.view setNeedsUpdateConstraints];
	[self.view layoutIfNeeded];
}

- (void)listenToTheCategoryDidChangedNofitication {
	__weak typeof(self) weakSelf = self;

	[[NSNotificationCenter defaultCenter] addObserverForName:TMEHomeCategoryDidChangedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock: ^(NSNotification *note) {
	    TMEDropDownMenuViewController *vc = note.object;
	    weakSelf.viewModel.currentCategory = vc.selectedCategory;
        weakSelf.currentCategory = vc.selectedCategory;
	    UIButton *centerBtn = [weakSelf.parentViewController.navigationItem.titleView getButton];
	    [centerBtn setTitle:weakSelf.viewModel.currentCategory.name forState:UIControlStateNormal];
	    [centerBtn setTitle:weakSelf.viewModel.currentCategory.name forState:UIControlStateSelected];
	}];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Reload

- (void)refreshCollectionProducts {
	[self.refreshView beginRefreshing];
	[self.viewModel reloadWithFinishBlock: ^(NSError *error) {
	    [self.refreshView endRefreshing];
	}];
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
