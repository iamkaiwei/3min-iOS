//
//  TMEDropDownDatasource.m
//  ThreeMin
//
//  Created by Triệu Khang on 28/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEDropDownDatasource.h"

static CGFloat kDropDownMenuCellHeight = 50;

@interface TMEDropDownDatasource()

@property (strong, nonatomic, readwrite) NSMutableArray *arrCategories;
@property (copy, nonatomic) IdentifierParserBlock identifierParserBlock;
@property (copy, nonatomic) CollectionViewCellConfigureBlock configureCellBlock;

@property (weak, nonatomic) UICollectionView *collectionView;

@end

@implementation TMEDropDownDatasource

- (id)initWithItems:(NSMutableArray *)items {
    self = [super init];
    if (self) {
        _arrCategories = items;
    }

    return self;
}

- (NSArray *)arrCategories {
    if (!_arrCategories) {
        _arrCategories = @[].mutableCopy;
    }
    return _arrCategories;
}

- (void)setCellAndFooterClasses:(UICollectionView *)collectionView {
    self.collectionView = collectionView;
    [collectionView registerNib:[TMEDropDownMenuCell defaultNib] forCellWithReuseIdentifier:NSStringFromClass([TMEDropDownMenuCell class])];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrCategories.count;
}

- (CollectionViewCellConfigureBlock)configureCellBlock {
    CollectionViewCellConfigureBlock configBlock = ^(id item, UICollectionViewCell *cell) {

    };
    return configBlock;
}

- (IdentifierParserBlock)identifierParserBlock {
    IdentifierParserBlock identifierBlock = ^(id item) {
        return NSStringFromClass([TMEDropDownMenuCell class]);
    };
    return identifierBlock;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    id item = [self itemAtIndexPath:indexPath];
    NSString *identifier = self.identifierParserBlock(item);
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    self.configureCellBlock(item, cell);
    return cell;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.arrCategories.count) {
        return nil;
    }

    return self.arrCategories[indexPath.row];
}

- (CGFloat)totalCellHeight {
    return 300;
    return [self.collectionView numberOfItemsInSection:0] * kDropDownMenuCellHeight;
}

@end
