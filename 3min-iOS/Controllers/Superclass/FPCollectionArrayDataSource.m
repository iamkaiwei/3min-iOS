//
//  FPArrayDataSource.m
//  FoxPlay
//
//  Created by iSlan on 5/21/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPCollectionArrayDataSource.h"

@interface FPCollectionArrayDataSource()

@property (copy, nonatomic) IdentifierParserBlock identifierParserBlock;
@property (copy, nonatomic) CollectionViewCellConfigureBlock configureCellBlock;

@end

@implementation FPCollectionArrayDataSource

- (id)initWithItems  :(NSArray *)items
identifierParserBlock:(IdentifierParserBlock)parserBlock
 configureCellBlock  :(CollectionViewCellConfigureBlock)configureCellBlock
{
    self = [super init];
    if (self) {
        _items = items;
        _identifierParserBlock = parserBlock;
        _configureCellBlock = configureCellBlock;
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath];
    NSString *identifier = self.identifierParserBlock(item);
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                           forIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.items.count) {
        return self.items[indexPath.row];
    }
    return nil;
}

@end
