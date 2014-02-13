//
//  TMEBaseArrayDataSource.m
//  PhotoButton
//
//  Created by Toan Slan on 2/10/14.
//
//

#import "TMEBaseArrayDataSource.h"

@implementation TMEBaseArrayDataSource

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
{
  self = [super init];
  if (self) {
    self.items = anItems;
    self.cellIdentifier = aCellIdentifier;
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
  return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  id cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                          forIndexPath:indexPath];
  id item = [self itemAtIndexPath:indexPath];
  
  if (self.configureCellBlock) {
    self.configureCellBlock(cell,item);
  }
  
  if([cell respondsToSelector:@selector(configCellWithData:)]){
    [cell performSelector:@selector(configCellWithData:) withObject:item];
  }
  return cell;
}

@end
