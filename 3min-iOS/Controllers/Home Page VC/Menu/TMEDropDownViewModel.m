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

@end

@implementation TMEDropDownViewModel

- (id)initWithCollectionView:(UICollectionView *)collectionView {
	self = [super init];
    NSParameterAssert(collectionView);
	if (self) {
        _collectionView = collectionView;
        _datasource = [[TMEDropDownDatasource alloc] initWithItems:self.arrCategories];
        _collectionView.dataSource = _datasource;
	}
	return self;
}

- (NSArray *)arrCategories {
	if (!_arrCategories) {
		_arrCategories = @[].mutableCopy;
	}
	return _arrCategories;
}

- (void)getCategories:(void (^)(NSArray *category, NSError *error))block {

    // on memory cache
    if (self.arrCategories.count > 0) {
        if (block) {
            block(self.arrCategories, nil);
        }
        return;
    }

	[[TMECategoryManager sharedManager] getAllCategoriesWithSuccess: ^(NSArray *categories) {
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

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.arrCategories.count) {
        return nil;
    }

    return self.arrCategories[indexPath.row];
}

@end
