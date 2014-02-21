//
//  TMEBaseArrayDataSource.m
//  PhotoButton
//
//  Created by Toan Slan on 2/10/14.
//
//

#import "TMEBaseArrayDataSource.h"

@implementation TMEBaseArrayDataSource

- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)aCellIdentifier
           delegate:(id)delegate
{
  self = [super init];
  if (self) {
    self.items = items;
    self.cellIdentifier = aCellIdentifier;
    self.delegate = delegate;
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
  if (self.delegate && [cell respondsToSelector:@selector(setDelegate:)]) {
    [cell performSelector:@selector(setDelegate:) withObject:self.delegate];
  }
  
  id item = [self itemAtIndexPath:indexPath];
  
  if([cell respondsToSelector:@selector(configCellWithData:)]){
    [cell performSelector:@selector(configCellWithData:) withObject:item];
  }
  return cell;
}

@end
