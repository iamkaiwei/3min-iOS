//
//  TMELeftMenuViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 28/9/13.
//
//

#import "TMELeftMenuViewController.h"
#import "TMELeftMenuTableViewCell.h"
#import "TMEHomeViewController.h"

static NSString * const LeftMenuTableViewCellIdentifier = @"TMELeftMenuTableViewCell";

@interface TMELeftMenuViewController ()
<IIViewDeckControllerDelegate>

@property (strong, nonatomic) NSArray *arrayCategories;
@property (strong, nonatomic) UIView *statusBarView;
@property (weak, nonatomic) IBOutlet UITableView *tableViewMenu;

@end

@implementation TMELeftMenuViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
    self.statusBarView = [[UIView alloc] initWithFrame:[[UIApplication sharedApplication] statusBarFrame]];
    [self.statusBarView setBackgroundColor:[UIColor blackColor]];
    [self.statusBarView setAlpha:0.0];
    [self.view addSubview:self.statusBarView];
    [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
  }
  
  [[TMECategoryManager sharedInstance] getAllCategoriesOnSuccessBlock:^(NSArray *arrayCategories) {
    _arrayCategories = arrayCategories;
    [self.tableView reloadData];
  } andFailureBlock:^(NSInteger statusCode, id obj) {
    
  }];
}

- (void)registerNibForTableView{
  self.tableView = self.tableViewMenu;
  self.arrayCellIdentifier = @[LeftMenuTableViewCellIdentifier];
}

#pragma mark - UITableView Datasource And Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayCategories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMELeftMenuTableViewCell *cell = (TMELeftMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMELeftMenuTableViewCell class]) forIndexPath:indexPath];
    TMECategory *category = [self.arrayCategories objectAtIndex:indexPath.row];
    [cell configCategoryCellWithCategory:category];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  TMECategory *category = [self.arrayCategories objectAtIndex:indexPath.row];
  NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
  [userInfo setObject:category forKey:@"category"];
  [[NSNotificationCenter defaultCenter] postNotificationName:CATEGORY_CHANGE_NOTIFICATION object:nil userInfo:userInfo];
  [self.viewDeckController closeLeftView];
}

- (void)viewDeckController:(IIViewDeckController *)viewDeckController didChangeOffset:(CGFloat)offset orientation:(IIViewDeckOffsetOrientation)orientation panning:(BOOL)panning{
  CGFloat percentVisible = offset/276;
  [self.statusBarView setAlpha:percentVisible];
  [((TMEHomeViewController *)self.viewDeckController.centerController) setStatusBarViewAlpha:percentVisible];
  DLog(@"%f",percentVisible);
}

-(UIStatusBarStyle)preferredStatusBarStyle{
  return UIStatusBarStyleLightContent;
}

@end
