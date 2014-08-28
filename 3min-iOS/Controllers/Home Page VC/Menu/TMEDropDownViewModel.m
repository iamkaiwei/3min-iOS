//
//  TMEDropDownViewModel.m
//  ThreeMin
//
//  Created by Triệu Khang on 28/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEDropDownViewModel.h"

@interface TMEDropDownViewModel ()

@property (strong, nonatomic, readwrite) TMEDropDownDatasource *datasource;
@property (strong, nonatomic, readwrite) NSMutableArray *arrCategories;
@property (weak, nonatomic) UICollectionView *collectionView;

@end

@implementation TMEDropDownViewModel

- (id)initWithCollectionView:(UICollectionView *)collectionView {
	self = [super init];
	if (self) {
        _collectionView = collectionView;
        _collectionView.dataSource = self.datasource;
	}
	return self;
}

- (TMEDropDownDatasource *)datasource {
    if (!_datasource) {
        _datasource = [[TMEDropDownDatasource alloc] initWithItems:self.arrCategories];
    }

    return _datasource;
}

- (NSArray *)arrCategories {
	if (!_arrCategories) {
		_arrCategories = @[].mutableCopy;
	}
	return _arrCategories;
}

- (void)getCategories:(void (^)(NSArray *category, NSError *error))block {
	[[TMECategoryManager sharedManager] getAllCategoriesWithSuccess: ^(NSArray *categories) {
//        self.arrCategories = [categories mutableCopy];
        [self willChangeValueForKey:@"arrCategories"];
        [self.arrCategories addObjectsFromArray:categories];
        [self didChangeValueForKey:@"arrCategories"];
	    if (block) {
	        block(categories, nil);
		}
	} failure: ^(NSError *error) {
	    if (block) {
	        block(nil, error);
		}
	}];
}

@end
