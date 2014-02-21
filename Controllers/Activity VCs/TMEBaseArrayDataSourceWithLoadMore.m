//
//  TMEActivityViewControllerArrayDataSource.m
//  PhotoButton
//
//  Created by Toan Slan on 2/10/14.
//
//

#import "TMEBaseArrayDataSourceWithLoadMore.h"
#import "TMEActivityTableViewCell.h"
#import "TMELoadMoreTableViewCell.h"

@implementation TMEBaseArrayDataSourceWithLoadMore

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
             paging:(BOOL)flag
    handleCellBlock:(LoadMoreCellHandleBlock)aHandleCellBlock
{
  self = [super initWithItems:anItems cellIdentifier:aCellIdentifier delegate:nil];
  if (self) {
    self.paging = flag;
    self.handleCellBlock = [aHandleCellBlock copy];
  }
  return self;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if(self.paging){
    return self.items.count + 1;
  }
  return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (self.paging && indexPath.row == self.items.count) {
    TMELoadMoreTableViewCell *cellLoadMore = [tableView dequeueReusableCellWithIdentifier:CELL_LOAD_MORE_IDENTIFIER];
    
    [cellLoadMore startLoading];
    
    cellLoadMore.backgroundColor = [UIColor whiteColor];
    cellLoadMore.labelLoading.textColor = [UIColor blackColor];
    
    self.handleCellBlock();
    return cellLoadMore;
  }
  
  id cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                          forIndexPath:indexPath];
  
  
  id item = [self itemAtIndexPath:indexPath];
  if([cell respondsToSelector:@selector(configCellWithData:)]){
    [cell performSelector:@selector(configCellWithData:) withObject:item];
  }
  return cell;
}


@end
