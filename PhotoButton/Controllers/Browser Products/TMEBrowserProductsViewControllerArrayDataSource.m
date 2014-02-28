//
//  TMEBrowserProductsViewControllerArrayDataSource.m
//  PhotoButton
//
//  Created by Toan Slan on 2/21/14.
//
//

#import "TMEBrowserProductsViewControllerArrayDataSource.h"

@implementation TMEBrowserProductsViewControllerArrayDataSource

- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)aCellIdentifier
             paging:(BOOL)paging
    handleCellBlock:(LoadMoreCellHandleBlock)handleLoadMoreCell
           delegate:(id)delegate
{
    self = [super initWithItems:items cellIdentifier:aCellIdentifier paging:paging handleCellBlock:handleLoadMoreCell];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(self.paging){
        return self.items.count + 1;
    }
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.paging && indexPath.section == self.items.count) {
        TMELoadMoreTableViewCell *cellLoadMore = [tableView dequeueReusableCellWithIdentifier:CELL_LOAD_MORE_IDENTIFIER];
        
        [cellLoadMore startLoading];
        
        cellLoadMore.backgroundColor = [UIColor whiteColor];
        
        self.handleCellBlock();
        return cellLoadMore;
    }
    
    id cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                              forIndexPath:indexPath];
    if (self.delegate && [cell respondsToSelector:@selector(setDelegate:)]) {
        [cell performSelector:@selector(setDelegate:) withObject:self.delegate];
    }
    
    id item = self.items[indexPath.section];
    
    if([cell respondsToSelector:@selector(configCellWithData:)]){
        [cell performSelector:@selector(configCellWithData:) withObject:item];
    }
    return cell;
}

@end
