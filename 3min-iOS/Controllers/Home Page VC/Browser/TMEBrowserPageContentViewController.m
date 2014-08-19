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
#import "TMELoadMoreCollectionCell.h"
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>

@interface TMEBrowserPageContentViewController ()
<
    UICollectionViewDelegateFlowLayout
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewProducts;
@property (strong, nonatomic) CHTCollectionViewWaterfallLayout *layout;
@property (strong, nonatomic) TMEBrowserProductViewModel *viewModel;
@property (strong, nonatomic) FBKVOController *kvoController;

@end

@implementation TMEBrowserPageContentViewController

#pragma mark - VC cycle

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.

	[self.collectionViewProducts registerNib:[TMELoadMoreCollectionCell defaultNib] forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([TMELoadMoreCollectionCell class])];
	[self.collectionViewProducts registerNib:[TMEProductCollectionViewCell defaultNib]
	              forCellWithReuseIdentifier:NSStringFromClass([TMEProductCollectionViewCell class])];

	[self configCollectionProducts];

	self.kvoController = [FBKVOController controllerWithObserver:self];

	[self.kvoController observe:self.viewModel keyPath:@"state" options:NSKeyValueObservingOptionNew block: ^(id observer, id object, NSDictionary *change) {
	    typeof(self) innerSelf = observer;
	    innerSelf.collectionViewProducts.dataSource = innerSelf.viewModel.datasource;
	    innerSelf.collectionViewProducts.delegate = innerSelf.viewModel.datasource;
	    [innerSelf.collectionViewProducts reloadData];
	}];
}

- (TMEBrowserProductViewModel *)viewModel {
	if (!_viewModel) {
		_viewModel = [[TMEBrowserProductViewModel alloc] initWithCollectionView:self.collectionViewProducts];
	}

	return _viewModel;
}

#pragma mark -

- (void)configCollectionProducts {
	self.layout = [self waterFlowLayout];
	self.collectionViewProducts.delegate = self.viewModel.datasource;
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

- (IBAction)reload:(id)sender {
	[self.viewModel getProducts:nil failure:nil];
}

#pragma mark - Collection datasource

//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//	CGSize contentSize = scrollView.contentSize;
//
//	CGFloat btm = (contentSize.height - targetContentOffset->y - scrollView.height);
//	BOOL shouldLoadMore = btm < 50;
//
//	if (shouldLoadMore) {
//		DLog(@"Shoud load more");
//		[self.viewModel getProducts:nil failure:nil];
//	}
//}

@end
