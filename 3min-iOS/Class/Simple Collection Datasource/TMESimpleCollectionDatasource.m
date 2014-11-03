//
//  TMESimpleCollectionDatasource.m
//  ThreeMin
//
//  Created by Triệu Khang on 1/10/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMESimpleCollectionDatasource.h"

@interface TMESimpleCollectionDatasource ()

@property (assign, nonatomic) Class cellClass;
@property (weak, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) id <TMEViewModelProtocol> viewModel;
@property (strong, nonatomic) RZCellSizeManager *sizeManager;

@end

@implementation TMESimpleCollectionDatasource

- initWithViewModel:(id <TMEViewModelProtocol> ) vm collectionView:(UICollectionView *)collectionView andCellClass:(Class)cellClass {
	self = [super init];
	if (self) {
		_cellClass = cellClass;
		_collectionView = collectionView;
		_viewModel = vm;
		_sizeManager = [[RZCellSizeManager alloc] init];


		[collectionView  registerNib:[_cellClass defaultNib]
		    forCellWithReuseIdentifier:[self _cellIdentifier]];

		[_sizeManager registerCellClassName:[self _cellIdentifier]
		                       withNibNamed:[self _cellIdentifier]
		                 forReuseIdentifier:[self _cellIdentifier]
		             withConfigurationBlock: ^(id cell, id object) {
		    if ([cell respondsToSelector:@selector(configWithData:)]) {
		        [cell performSelector:@selector(configWithData:) withObject:object];
			}
		}];
	}
	return self;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	// Retrieve our object to give to our size manager.
	id object = [self.viewModel itemAtIndexPath:indexPath];
	CGFloat height = [self.sizeManager cellHeightForObject:object
	                                             indexPath:indexPath
	                                   cellReuseIdentifier:[self _cellIdentifier]];
	return CGSizeMake(collectionView.frame.size.width, height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [self.viewModel numberOfItems];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self _cellIdentifier] forIndexPath:indexPath];
	id object = [self.viewModel itemAtIndexPath:indexPath];
	if ([cell respondsToSelector:@selector(configWithData:)]) {
		[cell performSelector:@selector(configWithData:) withObject:object];
	}
	return cell;
}

#pragma mark - Helper

- (NSString *)_cellIdentifier {
	return NSStringFromClass(self.cellClass);
}

@end
