//
//  TMEBrowserPageContentViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEBrowserPageContentViewController.h"
#import "TMEProductCollectionViewCell.h"
#import "TMEPaginationCollectionViewDataSource.h"
#import "TMEBrowserProductViewModel.h"
#import "TMELoadMoreCollectionFooterView.h"
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>

@interface TMEBrowserPageContentViewController ()
<
    UICollectionViewDelegateFlowLayout,
    TMEProductCollectionViewCellDelete
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewProducts;
@property (strong, nonatomic) UIRefreshControl *refreshView;
@property (strong, nonatomic) CHTCollectionViewWaterfallLayout *layout;
@property (strong, nonatomic) TMEBrowserProductViewModel *viewModel;
@property (strong, nonatomic) FBKVOController *kvoController;
@property (strong, nonatomic) LBDelegateMatrioska *chainDelegate;

@end

@implementation TMEBrowserPageContentViewController

#pragma mark - VC cycle

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.

	[self.collectionViewProducts registerNib:[TMELoadMoreCollectionFooterView defaultNib] forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([TMELoadMoreCollectionFooterView class])];
	[self.collectionViewProducts registerNib:[TMEProductCollectionViewCell defaultNib]
	              forCellWithReuseIdentifier:NSStringFromClass([TMEProductCollectionViewCell class])];

	[self configCollectionProducts];

	self.kvoController = [FBKVOController controllerWithObserver:self];

	[self.kvoController observe:self.viewModel keyPath:@"state" options:NSKeyValueObservingOptionNew block: ^(id observer, id object, NSDictionary *change) {
	    typeof(self) innerSelf = observer;
	    innerSelf.collectionViewProducts.dataSource = innerSelf.viewModel.datasource;
        innerSelf.viewModel.datasource.ownerViewController = self;
        innerSelf.chainDelegate = [[LBDelegateMatrioska alloc] initWithDelegates:@[innerSelf.viewModel.datasource, innerSelf]];
	    innerSelf.collectionViewProducts.delegate = (id <UICollectionViewDelegate> )innerSelf.chainDelegate;
	    [innerSelf.collectionViewProducts reloadData];
	}];

    [self addPullToRefresh];

    self.parentViewController.navigationItem.titleView = [self titleView];
}

- (UIView *)titleView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(60, 0, 200, 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:titleView.bounds];
    label.text = @"Khang";
    [titleView addSubview:label];
    return titleView;
}

- (void)addPullToRefresh {
    self.refreshView = [[UIRefreshControl alloc] init];
    [self.collectionViewProducts addSubview:self.refreshView];
    [self.refreshView addTarget:self action:@selector(refreshCollectionProducts) forControlEvents:UIControlEventValueChanged];
}

- (TMEBrowserProductViewModel *)viewModel {
	if (!_viewModel) {
		_viewModel = [[TMEBrowserProductViewModel alloc] initWithCollectionView:self.collectionViewProducts];
        _viewModel.datasource.ownerViewController = self;
	}

	return _viewModel;
}

#pragma mark -

- (void)configCollectionProducts {
	self.layout = [self waterFlowLayout];
	self.collectionViewProducts.delegate = (id<UICollectionViewDelegate>) self.chainDelegate;
	self.collectionViewProducts.dataSource = self.viewModel.datasource;
	self.collectionViewProducts.collectionViewLayout = self.layout;
	[self.collectionViewProducts setContentInset:UIEdgeInsetsMake(10, 0, 10, 0)];
}

#pragma mark -

- (CHTCollectionViewWaterfallLayout *)waterFlowLayout {
	CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
	layout.columnCount = 2;
	layout.minimumColumnSpacing = 5;
	layout.minimumInteritemSpacing = 6;
	return layout;
}

#pragma mark - Reload

- (void)refreshCollectionProducts {
    [self.refreshView beginRefreshing];
    [self.viewModel reloadWithFinishBlock:^(NSError *error) {
        [self.refreshView endRefreshing];
    }];
}

#pragma mark - Collection delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TMEProduct *product = (TMEProduct *)[self.viewModel itemAtIndexPath:indexPath];
    ProductCollectionCellAct(self, product, TMEProductCollectionCellGoDetails);
}

- (void)tapOnLikeProductOnCell:(TMEProductCollectionViewCell *)cell {
    NSIndexPath *indexPath = [self.collectionViewProducts indexPathForCell:cell];
    TMEProduct *product = (TMEProduct *)[self.viewModel itemAtIndexPath:indexPath];
    ProductCollectionCellAct(self, product, TMEProductCollectionCellLike);
}

- (void)tapOnCommentProductOnCell:(TMEProductCollectionViewCell *)cell {
    NSIndexPath *indexPath = [self.collectionViewProducts indexPathForCell:cell];
    TMEProduct *product = (TMEProduct *)[self.viewModel itemAtIndexPath:indexPath];
    ProductCollectionCellAct(self, product, TMEProductCollectionCellComment);
}

- (void)tapOnShareProductOnCell:(TMEProductCollectionViewCell *)cell {
    NSIndexPath *indexPath = [self.collectionViewProducts indexPathForCell:cell];
    TMEProduct *product = (TMEProduct *)[self.viewModel itemAtIndexPath:indexPath];
    ProductCollectionCellAct(self, product, TMEProductCollectionCellShare);
}

@end
