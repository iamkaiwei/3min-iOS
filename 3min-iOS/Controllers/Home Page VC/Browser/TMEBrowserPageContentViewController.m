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
    UICollectionViewDelegateFlowLayout,
    CHTCollectionViewDelegateWaterfallLayout
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewProducts;
@property (strong, nonatomic) CHTCollectionViewWaterfallLayout *layout;
@property (strong, nonatomic) TMEPaginationCollectionViewDataSource *datasource;
@property (strong, nonatomic) TMEBrowserProductViewModel *viewModel;
@property (strong, nonatomic) FBKVOController *kvoController;

@end

@implementation TMEBrowserPageContentViewController

#pragma mark - VC cycle

- (void)viewDidLoad {

	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.

    [self configCollectionProducts];

    self.kvoController = [FBKVOController controllerWithObserver:self];
    [self.kvoController observe:self.viewModel keyPath:@"arrayItems" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        typeof(self) innerSelf = observer;
        innerSelf.datasource.items = change[NSKeyValueChangeNewKey];
        [innerSelf.collectionViewProducts reloadData];
    }];

    [self.viewModel getProducts:nil failure:nil];
}

- (TMEPaginationCollectionViewDataSource *)datasource {
    if (!_datasource) {
        _datasource = [[TMEPaginationCollectionViewDataSource alloc] initWithItems:self.viewModel.arrayItems identifierParserBlock:nil configureCellBlock:nil];
        [_datasource setClassAndFooterClasses:self.collectionViewProducts];
    }

    return _datasource;
}

- (TMEBrowserProductViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[TMEBrowserProductViewModel alloc] init];
    }

    return _viewModel;
}

#pragma mark -

- (void)configCollectionProducts {
    self.layout = [self waterFlowLayout];
	self.collectionViewProducts.delegate = self;
	self.collectionViewProducts.dataSource = self.datasource;
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

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGSize contentSize = scrollView.contentSize;

    CGFloat btm = ( contentSize.height - targetContentOffset->y - scrollView.height );
    BOOL shouldLoadMore = btm < 50;

    if (shouldLoadMore) {
        DLog(@"Shoud load more");
        [self.viewModel getProducts:nil failure:nil];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	return CGSizeMake(152, 330);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section {
    return 50;
}

@end
