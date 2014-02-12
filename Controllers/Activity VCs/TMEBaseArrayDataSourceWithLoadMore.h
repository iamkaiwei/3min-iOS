//
//  TMEActivityViewControllerArrayDataSource.h
//  PhotoButton
//
//  Created by Toan Slan on 2/10/14.
//
//

#import "TMEBaseArrayDataSource.h"

typedef void (^LoadMoreCellHandleBlock)();

@interface TMEBaseArrayDataSourceWithLoadMore : TMEBaseArrayDataSource

@property (nonatomic, assign) BOOL paging;
@property (nonatomic, copy) LoadMoreCellHandleBlock handleCellBlock;

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
             paging:(BOOL)flag
    handleCellBlock:(LoadMoreCellHandleBlock)aHandleCellBlock;

@end
