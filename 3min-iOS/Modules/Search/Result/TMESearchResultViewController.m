//
//  TMESearchResultViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 7/9/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMESearchResultViewController.h"
#import "TMEProductCollectionViewCell.h"
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>

@interface TMESearchResultViewController ()
<
    UICollectionViewDelegateFlowLayout,
    TMEProductCollectionViewCellDelegate
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewResult;
@property (strong, nonatomic) FBKVOController *kvoController;
@property (strong, nonatomic, readwrite) TMESearchResultViewModel *viewModel;
@property (strong, nonatomic) CHTCollectionViewWaterfallLayout *layout;
@property (strong, nonatomic) LBDelegateMatrioska *chainDelegate;

@end

@implementation TMESearchResultViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    [[FLEXManager sharedManager] showExplorer];

    // Do any additional setup after loading the view from its nib.
	[self.collectionViewResult registerNib:[TMEProductCollectionViewCell defaultNib]
	              forCellWithReuseIdentifier:NSStringFromClass([TMEProductCollectionViewCell class])];
	[self configCollectionProducts];
	[self reloadCollectionWheneverViewModelStateChanged];
}

- (void)reloadCollectionWheneverViewModelStateChanged {
	self.kvoController = [FBKVOController controllerWithObserver:self];

	[self.kvoController observe:self.viewModel keyPath:@"state" options:NSKeyValueObservingOptionNew block: ^(id observer, id object, NSDictionary *change) {
	    typeof(self) innerSelf = observer;
	    innerSelf.collectionViewResult.dataSource = innerSelf.viewModel.datasource;
	    innerSelf.viewModel.datasource.ownerViewController = self;
	    innerSelf.chainDelegate = [[LBDelegateMatrioska alloc] initWithDelegates:@[innerSelf.viewModel.datasource, innerSelf]];
	    innerSelf.collectionViewResult.delegate = (id)innerSelf.chainDelegate;
	    [innerSelf.collectionViewResult reloadData];
	}];
}

- (TMESearchResultViewModel *)viewModel {
	if (!_viewModel) {
		_viewModel = [[TMESearchResultViewModel alloc] initWithCollectionView:self.collectionViewResult];
		_viewModel.datasource.ownerViewController = self;
	}

	return _viewModel;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configCollectionProducts {
	self.layout = [self waterFlowLayout];
	self.collectionViewResult.delegate = self;
	self.collectionViewResult.dataSource = self.viewModel.datasource;
	self.collectionViewResult.collectionViewLayout = self.layout;
	[self.collectionViewResult setContentInset:UIEdgeInsetsMake(10, 0, 10, 0)];
}

- (CHTCollectionViewWaterfallLayout *)waterFlowLayout {
	CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
	layout.columnCount = 2;
	layout.minimumColumnSpacing = 5;
	layout.minimumInteritemSpacing = 6;
	return layout;
}

@end
