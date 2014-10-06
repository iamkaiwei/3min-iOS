//
//  TMESearchResultViewModel.m
//  ThreeMin
//
//  Created by Triệu Khang on 7/9/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMESearchResultViewModel.h"
#import "TMESearchNetworkClient.h"
#import "TMEProduct+ProductCellHeight.h"
#import "TMEPaginationCollectionViewDataSource.h"

@interface TMESearchResultViewModel()

@property (copy, nonatomic, readwrite) NSMutableArray *arrayItems;

@property (nonatomic, readwrite) TMEViewModelState state;

@property (nonatomic, readwrite, strong) TMEPaginationCollectionViewDataSource *datasource;

@property (weak, nonatomic) UICollectionView *collectionView;

@property (nonatomic, strong) TMESearchNetworkClient *searchNetworkClient;

@end

@implementation TMESearchResultViewModel

- (instancetype)init {
	NSAssert(NO, @"Have to use initWithCollectionView:");
	self = [self initWithCollectionView:nil];
	if (self) {
	}

	return self;
}

- (NSMutableArray *)arrayItems {
	if (!_arrayItems) {
		_arrayItems = [@[] mutableCopy];
	}

	return _arrayItems;
}

- (TMEPaginationCollectionViewDataSource *)datasource {
    if (!_datasource) {
        _datasource = [[TMEPaginationCollectionViewDataSource alloc] initWithItems:self.arrayItems identifierParserBlock:nil configureCellBlock:nil];
        _collectionView.dataSource = _datasource;
        [_datasource setCellAndFooterClasses:self.collectionView];
    }

    return _datasource;
}

- (id)initWithCollectionView:(UICollectionView *)collection {
	self = [super init];

	NSAssert(collection, @"Collection shouldn't be nil");

	if (self) {
        _searchNetworkClient = [[TMESearchNetworkClient alloc] init];
		_state = TMEViewModelStateIntial;
		_collectionView = collection;
	}
	return self;
}

- (void)setSearchString:(NSString *)searchString {
    _searchString = searchString;
    [self searchWithString:searchString success:nil failure:nil];
}

- (void)searchWithString:(NSString *)key success:(void(^)(NSArray *))successBlock failure:(void(^)(NSError *))failureBlock {

	if (self.state == TMEViewModelStateLoading) {
		return;
	}

	// change state to loading state
	self.state = TMEViewModelStateLoading;

    [self.searchNetworkClient search:key sucess:^(NSArray *results) {

		self.state = TMEViewModelStateLoaded;
        [self.arrayItems removeAllObjects];
        [self.arrayItems addObjectsFromArray:results];

		// caculate the height
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void) {
		    [self.arrayItems enumerateObjectsUsingBlock: ^(TMEProduct *product, NSUInteger idx, BOOL *stop) {
		        [product productCellHeight];
			}];
		    dispatch_async(dispatch_get_main_queue(), ^(void) {
		        if (successBlock) {
		            successBlock(self.arrayItems);
				}
			});
		});

    } failure:^(NSError *error) {

    }];
}

@end
