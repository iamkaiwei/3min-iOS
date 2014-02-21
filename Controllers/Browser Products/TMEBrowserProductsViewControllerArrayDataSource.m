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
   headerIdentifier:(NSString *)aHeaderIdentifier
           delegate:(id)delegate
{
  self = [super initWithItems:items cellIdentifier:aCellIdentifier delegate:delegate];
  if (self) {
    self.headerIdentifier = aHeaderIdentifier;
  }
  return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return self.items.count;
}

@end
