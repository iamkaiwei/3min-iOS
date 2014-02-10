//
//  TMEBaseTableViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 12/9/13.
//
//

#import "TMEBaseTableViewController.h"

@interface TMEBaseTableViewController ()

@end

@implementation TMEBaseTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  [self registerNibForTableView];
  for (int i = 0; i < self.arrayCellIdentifier.count; i++) {
    NSString *cellIdentifier = self.arrayCellIdentifier[i];
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
  }
}

- (void)registerNibForTableView{
  return;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  DLog(@"This method should be overrided in subclass");
  return nil;
}

#pragma mark - Helpers

- (void)deselectAllCellsAnimated:(BOOL)animated
{
  for (UITableViewCell *cell in self.tableView.visibleCells)
  {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableView deselectRowAtIndexPath:indexPath animated:animated];
  }
}
- (void)fadeInTableView
{
  [self fadeInTableViewOnCompletion:nil];
}

- (void)fadeInTableViewOnCompletion:(void (^)(BOOL finished))completion
{
  [UIView animateWithDuration:0.3 animations:^{
    self.tableView.alpha = 1;
  } completion:completion];
}

- (void)fadeOutTableView
{
  [self fadeOutTableViewOnCompletion:nil];
}

- (void)fadeOutTableViewOnCompletion:(void (^)(BOOL finished))completion
{
  [UIView animateWithDuration:0.3 animations:^{
    self.tableView.alpha = 0;
  } completion:completion];
}

- (void)refreshTableViewAnimated:(BOOL)animated
{
  if (animated == NO) {
    [self.tableView reloadData];
    
    if (self.dataArray != nil) {
      self.tableView.hidden = [self.dataArray count] <= 0;
      self.lblInstruction.hidden = !self.tableView.hidden;
    }
    return;
  }
  
  [self refreshTableViewOnCompletion:nil];
}

- (void)refreshTableViewOnCompletion:(void (^)(BOOL finished))completion
{
  [self fadeOutTableViewOnCompletion:^(BOOL finished) {
    [self.tableView reloadData];
    
    if (self.dataArray != nil) {
      self.tableView.hidden = [self.dataArray count] <= 0;
      self.lblInstruction.hidden = !self.tableView.hidden;
    }
    [self fadeInTableViewOnCompletion:completion];
  }];
}

@end
