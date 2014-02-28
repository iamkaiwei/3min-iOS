//
//  TMEBrowserProductsViewControllerArrayDataSource.h
//  PhotoButton
//
//  Created by Toan Slan on 2/21/14.
//
//

#import <Foundation/Foundation.h>

@interface TMEBrowserProductsViewControllerArrayDataSource : TMEBaseArrayDataSourceWithLoadMore

- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)aCellIdentifier
             paging:(BOOL)paging
    handleCellBlock:(LoadMoreCellHandleBlock)handleLoadMoreCell
           delegate:(id)delegate;

@end
