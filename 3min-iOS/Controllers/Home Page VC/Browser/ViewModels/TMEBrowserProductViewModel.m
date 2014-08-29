//  TMEBrowserProductViewModel.m
//  ThreeMin
//
//  Created by Triệu Khang on 15/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEBrowserProductViewModel.h"
#import "TMEErrorCollectionViewDataSource.h"
#import "TMEDropDownMenuViewController.h"

@interface TMEBrowserProductViewModel ()

@property (copy, nonatomic, readwrite) NSArray *arrayItems;

@property (nonatomic, readwrite) TMEViewModelState state;

@property (nonatomic, readwrite, strong) TMEPaginationCollectionViewDataSource *datasource;

@property (strong, nonatomic) FBKVOController *kvoController;

@property (weak, nonatomic) UICollectionView *collectionView;

@property (assign, nonatomic) NSUInteger page;

@property (strong, nonatomic) TMECategory *currentCategory;

@end

@implementation TMEBrowserProductViewModel

- (id)init {
	NSAssert(NO, @"Have to use initWithCollectionView:");
	self = [self initWithCollectionView:nil];
	if (self) {
	}

	return self;
}

- (id)initWithCollectionView:(UICollectionView *)collection {
	self = [super init];

	NSAssert(collection, @"Collection shouldn't be nil");

	if (self) {
		// nil means all
		_currentCategory = nil;

		_page = 1;
		self.state = TMEViewModelStateIntial;
		_kvoController = [FBKVOController controllerWithObserver:self];

		__weak UICollectionView *weakCollection = collection;

		[_kvoController observe:collection keyPath:@"contentOffset" options:NSKeyValueObservingOptionNew block: ^(id observer, id object, NSDictionary *change) {
		    UICollectionView *collectionView = weakCollection;
		    CGSize contentSize = collectionView.contentSize;

		    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
		    CGFloat btm = (contentSize.height - collectionView.contentOffset.y - screenHeight);
		    BOOL shouldLoadMore = btm < 50;

		    if (shouldLoadMore) {
		        DLog(@"Shoud load more");
		        [self getProducts:nil failure:nil];
			}
		}];

		_collectionView = collection;

		__weak typeof(self) weakSelf = self;

		[[NSNotificationCenter defaultCenter] addObserverForName:TMEHomeCategoryDidChangedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock: ^(NSNotification *note) {
		    TMEDropDownMenuViewController *vc = note.object;
		    weakSelf.currentCategory = vc.selectedCategory;
		}];
	}
	return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -

- (void)setCurrentCategory:(TMECategory *)currentCategory {
	_currentCategory = currentCategory;
	[self reload];
}

- (void)setState:(TMEViewModelState)state {
	_state = state;
	self.datasource = (id)[self dataSourceFactory : state];
}

- (NSArray *)arrayItems {
	if (!_arrayItems) {
		_arrayItems = @[];
	}

	return _arrayItems;
}

#pragma mark -

- (id <UICollectionViewDataSource> )dataSourceFactory:(TMEViewModelState)state {
#warning NEED REFACTOR
	// if there is loading state, then keep the current datasource
	if (self.state == TMEViewModelStateLoading ||
	    self.state == TMEViewModelStateLoadingMorePage) {
		if ([self.datasource isKindOfClass:[TMEPaginationCollectionViewDataSource class]]) {
			return self.datasource;
		}
	}

	if (self.state == TMEViewModelStateError) {
		return [[TMEErrorCollectionViewDataSource alloc] init];
	}

	return [[TMEPaginationCollectionViewDataSource alloc] initWithItems:self.arrayItems identifierParserBlock:nil configureCellBlock:nil];

//	if (state == TMEViewModelStateLoadingMorePage) {
//		return [[TMEPaginationCollectionViewDataSource alloc] init];
//	}
//
//	return [[TMEPaginationCollectionViewDataSource alloc] init];
}

- (void)setDatasource:(TMEPaginationCollectionViewDataSource *)datasource {
	_datasource = datasource;
	[_datasource setCellAndFooterClasses:self.collectionView];
	self.collectionView.dataSource = _datasource;
}

#pragma mark - Get remote products

- (void)reload {
	[self reloadWithFinishBlock:nil];
}

- (void)reloadWithFinishBlock:(void (^)(NSError *error))finishBlock {
	self.page = 1;
	self.arrayItems = @[].mutableCopy;
	self.state = TMEViewModelStateIntial;

	[self getProducts: ^(NSArray *arrProducts) {
	    if (finishBlock) {
	        finishBlock(nil);
		}
	} failure: ^(NSError *error) {
	    if (finishBlock) {
	        finishBlock(error);
		}
	}];
}

- (void)getProducts:(void (^)(NSArray *arrProducts))success failure:(void (^)(NSError *error))failure withPage:(NSUInteger)page {
	// prevent mutiple loading
	if (self.state == TMEViewModelStateLoading) {
		return;
	}

	// finish loading
	if (self.page == -1) {
		return;
	}

	// change state to loading state
	self.state = TMEViewModelStateLoading;

#warning NEED REFACTOR
	if (self.currentCategory) {
		[TMEProductsManager getProductsOfCategory:self.currentCategory
		                                 withPage:page
		                           onSuccessBlock: ^(NSArray *arrProducts) {
		    if (arrProducts.count == 0) {
		        self.page = -1;
		        return;
			}

		    NSMutableArray *arr = [self.arrayItems mutableCopy];
		    [arr addObjectsFromArray:arrProducts];
		    self.arrayItems = arr;
		    self.page++;

		    self.state = TMEViewModelStateLoaded;

		    if (success) {
		        success(arrProducts);
			}
		} failureBlock: ^(NSError *error) {
		    self.state = TMEViewModelStateError;
		    if (failure) {
		        failure(error);
			}
		}];
		return;
	}

	[TMEProductsManager getAllProductsWihPage:page
	                           onSuccessBlock: ^(NSArray *arrProducts) {
	    if (arrProducts.count == 0) {
	        self.page = -1;
	        return;
		}

	    NSMutableArray *arr = [self.arrayItems mutableCopy];
	    [arr addObjectsFromArray:arrProducts];
	    self.arrayItems = arr;
	    self.page++;

	    self.state = TMEViewModelStateLoaded;

	    if (success) {
	        success(arrProducts);
		}
	} failureBlock: ^(NSError *error) {
	    self.state = TMEViewModelStateError;
	    if (failure) {
	        failure(error);
		}
	}];
}

- (void)getProducts:(void (^)(NSArray *arrProducts))success failure:(void (^)(NSError *error))failure {
	[self getProducts:success failure:failure withPage:self.page];
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row > self.arrayItems.count) {
		return nil;
	}

	return self.arrayItems[indexPath.row];
}

@end
