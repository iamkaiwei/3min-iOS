//
//  TMEFollowingsViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 1/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEFollowingsViewController.h"
#import "TMEFollowingsCellFactory.h"
#import "TMEFollowingLoadingOperation.h"
#import <KHTableViewController/KHCollectionController.h>
#import <KHTableViewController/KHContentLoadingSectionViewModel.h>
#import <KHTableViewController/KHOrderedDataProvider.h>

@interface TMEFollowingsViewController ()
<
    KHOrderedDataProtocol
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//@property (strong, nonatomic) KHCollectionController *collectionController;
//@property (strong, nonatomic) TMEFollowingsCellFactory *cellFactory;
//
//@property (strong, nonatomic) KHOrderedDataProvider *dataProvider;
@property (strong, nonatomic) TMEUser *user;

@end

@implementation TMEFollowingsViewController

- (void)loadView {
    [super loadView];
}

- (instancetype)initWithUser:(TMEUser *)user {
	self = [super init];
	if (self) {
		_user = user;
	}

	return self;
}

- (id<KHCollectionViewCellFactoryProtocol>)cellFactory {
    return [[TMEFollowingsCellFactory alloc] init];
}

- (id<KHTableViewSectionModel>)getLoadingContentViewModel {
    return [[KHOrderedDataProvider alloc] init];
}

- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel forPage:(NSUInteger)page {
	return [[TMEFollowingLoadingOperation alloc] initUserID:[self.user.userID integerValue] page:page + 1];
}

//- (void)viewDidLoad {
//	[super viewDidLoad];
//	// Do any additional setup after loading the view from its nib.
//
//	self.cellFactory = [[TMEFollowingsCellFactory alloc] init];
//
//	self.collectionView.delegate = self.collectionController;
//	self.collectionView.dataSource = self.collectionController;
//	[self.collectionView reloadData];
//
//	self.dataProvider = [[KHOrderedDataProvider alloc] init];
//	self.dataProvider.delegate = self;
//	[self.dataProvider startLoading];
//}
//
//- (KHCollectionController *)collectionController {
//	if (!_collectionController) {
//		_collectionController = [[KHCollectionController alloc] init];
//
//		KHBasicTableViewModel *colModel = [[KHBasicTableViewModel alloc] init];
//		colModel.sectionModel = [[KHContentLoadingSectionViewModel alloc] init];
//
//		// set the cell factory
//		_collectionController.cellFactory = self.cellFactory;
//
//		_collectionController.model = colModel;
//	}
//
//	return _collectionController;
//}
//
//- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel forPage:(NSUInteger)page {
//	return [[TMEFollowingLoadingOperation alloc] initUserID:[self.user.userID integerValue] page:page + 1];
//}
//
//- (void)dataProvider:(KHOrderedDataProvider *)dataProvider didLoadDataAtPage:(NSUInteger)page withItems:(NSArray *)items error:(NSError *)error {
//	if (page == 1) {
//		KHBasicTableViewModel *contentViewModel = [[KHBasicTableViewModel alloc] init];
//		contentViewModel.sectionModel = self.dataProvider;
//		self.collectionController.model = contentViewModel;
//	}
//
//	[self.collectionView reloadData];
//}
//
//- (id<KHContentLoadingProtocol, KHTableViewSectionModel>)getLoadingContentViewModel {
//    return [[KHOrderedDataProvider alloc] init];;
//}

- (void)dataProvider:(KHOrderedDataProvider *)dataProvider didLoadDataAtPage:(NSUInteger)page withItems:(NSArray *)items error:(NSError *)error {
    [self.collectionView reloadData];
}

@end
