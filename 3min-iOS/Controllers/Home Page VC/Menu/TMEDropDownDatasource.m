//
//  TMEDropDownDatasource.m
//  ThreeMin
//
//  Created by Triệu Khang on 28/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEDropDownDatasource.h"

@interface TMEDropDownDatasource()

@property (strong, nonatomic, readwrite) NSArray *arrCategories;
@property (copy, nonatomic) IdentifierParserBlock identifierParserBlock;
@property (copy, nonatomic) CollectionViewCellConfigureBlock configureCellBlock;

@end

@implementation TMEDropDownDatasource

- (id)initWithItems:(NSArray *)items {
    self = [super initWithItems:items identifierParserBlock:nil configureCellBlock:nil];
    if (self) {
    }

    return self;
}

- (void)setCellAndFooterClasses:(UICollectionView *)collectionView {
    [collectionView registerNib:[TMEDropDownMenuCell defaultNib] forCellWithReuseIdentifier:NSStringFromClass([TMEDropDownMenuCell class])];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (CollectionViewCellConfigureBlock)configBlock {
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

@end
