//
//  TMEBaseTableViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 12/9/13.
//
//

#import "TMEBaseTableViewController.h"

static NSString * const kLoadMoreCellIdentifier = @"TMELoadMoreTableViewCell";

@interface TMEBaseTableViewController ()

@property (strong, nonatomic) NSNumber * currentCellHeight;

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
  if (self.registerLoadMoreCell) {
    [self.tableView registerNib:[UINib nibWithNibName:kLoadMoreCellIdentifier bundle:nil] forCellReuseIdentifier:kLoadMoreCellIdentifier];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (1 != self.arrayCellIdentifier.count)
    return 44;
  
  if(self.currentCellHeight)
    return self.currentCellHeight.floatValue;
  
  NSString * customCellIdentifier = self.arrayCellIdentifier[0];
  NSArray * nibViews = [[NSBundle mainBundle] loadNibNamed:customCellIdentifier
                                                     owner:nil
                                                   options:nil];
  UITableViewCell * cell = nibViews[0];
  self.currentCellHeight = @(cell.height);
  
  return cell.height;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
  if ([cell respondsToSelector:@selector(didSelectCellAnimation)]) {
    [cell performSelector:@selector(didSelectCellAnimation)];
  }
  return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
  if ([cell respondsToSelector:@selector(didDeselectCellAnimation)]) {
    [cell performSelector:@selector(didDeselectCellAnimation)];
  }
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
