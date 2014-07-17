//
//  TMEBrowserCollectionViewDataSource.m
//  PhotoButton
//
//  Created by Toan Slan on 3/3/14.
//
//

#import "TMEBrowserCollectionViewDataSource.h"
#import "TMEBrowserCollectionCell.h"
#import "TMELoadMoreCollectionViewCell.h"

@implementation TMEBrowserCollectionViewDataSource

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
             paging:(BOOL)flag
           delegate:(id)delegate
    handleCellBlock:(LoadMoreCellHandleBlock)aHandleCellBlock
{
    self = [super init];
    if (self) {
        self.items = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.delegate = delegate;
        self.paging = flag;
        self.handleCellBlock = [aHandleCellBlock copy];
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[(NSUInteger) indexPath.row];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.paging){
        return self.items.count + 1;
    }
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.paging && indexPath.row == self.items.count) {
        TMELoadMoreCollectionViewCell *cellLoadMore = [collectionView dequeueReusableCellWithReuseIdentifier:[TMELoadMoreCollectionViewCell kind] forIndexPath:indexPath];
        
        [cellLoadMore startLoading];
        
        self.handleCellBlock();
        return cellLoadMore;
    }
    
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TMEBrowserCollectionCell kind] forIndexPath:indexPath];
    
    id item = [self itemAtIndexPath:indexPath];
    
    if([cell respondsToSelector:@selector(configCellWithData:)]){
        [cell performSelector:@selector(configCellWithData:) withObject:item];
    }
    
    return cell;
}

@end
