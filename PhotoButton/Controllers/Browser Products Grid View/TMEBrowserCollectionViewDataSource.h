//
//  TMEBrowserCollectionViewDataSource.h
//  PhotoButton
//
//  Created by Toan Slan on 3/3/14.
//
//

#import <Foundation/Foundation.h>

typedef void (^LoadMoreCellHandleBlock)();

@interface TMEBrowserCollectionViewDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, strong) id delegate;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, assign) BOOL paging;
@property (nonatomic, copy) LoadMoreCellHandleBlock handleCellBlock;

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
             paging:(BOOL)flag
           delegate:(id)delegate
    handleCellBlock:(LoadMoreCellHandleBlock)aHandleCellBlock;

@end
