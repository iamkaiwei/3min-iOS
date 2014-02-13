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
#import "TMEBaseArrayDataSource.h"

static NSString * const kLeftMenuTableViewCellIdentifier = @"TMELeftMenuTableViewCell";

@interface TMELeftMenuViewController ()
<IIViewDeckControllerDelegate>

@property (strong, nonatomic) NSArray *arrayCategories;
@property (strong, nonatomic) UIView *statusBarView;
@property (strong, nonatomic) TMEBaseArrayDataSource *categoryArrayDataSource;

@end

@implementation TMELeftMenuViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
    [self handleStatusBarAnimation];
    [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
  }
  
  [self getAllCategories];
}

- (void)registerNibForTableView{
  self.arrayCellIdentifier = @[kLeftMenuTableViewCellIdentifier];
}

- (void)setUpTableView{
  self.categoryArrayDataSource = [[TMEBaseArrayDataSource alloc] initWithItems:self.arrayCategories cellIdentifier:kLeftMenuTableViewCellIdentifier configureCellBlock:nil];
  
  self.tableView.dataSource = self.categoryArrayDataSource;
  [self.tableView reloadData];
}

#pragma mark - UITableView Delegate

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

- (void)getAllCategories{
  [[TMECategoryManager sharedInstance] getAllCategoriesOnSuccessBlock:^(NSArray *arrayCategories) {
    _arrayCategories = arrayCategories;
    [self setUpTableView];
  } andFailureBlock:^(NSInteger statusCode, id obj) {
    DLog(@"%d", statusCode);
  }];
}

- (void)handleStatusBarAnimation{
  self.statusBarView = [[UIView alloc] initWithFrame:[[UIApplication sharedApplication] statusBarFrame]];
  [self.statusBarView setBackgroundColor:[UIColor blackColor]];
  [self.statusBarView setAlpha:0.0];
  [self.view addSubview:self.statusBarView];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
  return UIStatusBarStyleLightContent;
}

@end
