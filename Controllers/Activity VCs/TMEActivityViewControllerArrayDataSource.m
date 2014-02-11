//
//  TMEActivityViewControllerArrayDataSource.m
//  PhotoButton
//
//  Created by Toan Slan on 2/10/14.
//
//

#import "TMEActivityViewControllerArrayDataSource.h"
#import "TMEActivityTableViewCell.h"
#import "TMELoadMoreTableViewCell.h"

@interface TMEActivityViewControllerArrayDataSource()

@property (nonatomic, assign) BOOL paging;
@property (nonatomic, copy) NSString *cellLoadMoreIdentifier;

@end

@implementation TMEActivityViewControllerArrayDataSource

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
cellLoadMoreIdentifier:(NSString *)aCellLoadMoreIdentifier
             paging:(BOOL)flag
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
    handleCellBlock:(TableViewCellHandleBlock)aHandleCellBlock
{
  self = [super init];
  if (self) {
    self.paging = flag;
    self.items = anItems;
    self.cellIdentifier = aCellIdentifier;
    self.cellLoadMoreIdentifier = aCellLoadMoreIdentifier;
    self.handleCellBlock = [aHandleCellBlock copy];
    self.configureCellBlock = [aConfigureCellBlock copy];
  }
  return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
  return self.items[(NSUInteger) indexPath.row];
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
    TMELoadMoreTableViewCell *cellLoadMore = [tableView dequeueReusableCellWithIdentifier:self.cellLoadMoreIdentifier];
    [cellLoadMore startLoading];
    self.handleCellBlock();
    return cellLoadMore;
  }
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                          forIndexPath:indexPath];
  id item = [self itemAtIndexPath:indexPath];
  self.configureCellBlock(cell, item);
  return cell;
}


@end
