//
//  TMELeftMenuViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 28/9/13.
//
//

#import "TMELeftMenuViewController.h"
#import "TMELeftMenuTableViewCell.h"

@interface TMELeftMenuViewController ()

@property (strong, nonatomic) NSArray *arrayCategories;

@end

@implementation TMELeftMenuViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.tableView registerNib:[TMELeftMenuTableViewCell defaultNib] forCellReuseIdentifier:NSStringFromClass([TMELeftMenuTableViewCell class])]; //iOS 6+
  
  [[TMECategoryManager sharedInstance] getAllCategoriesOnSuccessBlock:^(NSArray *arrayCategories) {
    _arrayCategories = arrayCategories;
    [self.tableView reloadData];
  } andFailureBlock:^(NSInteger statusCode, id obj) {
    
  }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - UITableView Datasource And Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayCategories.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TMELeftMenuTableViewCell getHeight];
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
  [self.viewDeckController closeLeftView];
}

@end
