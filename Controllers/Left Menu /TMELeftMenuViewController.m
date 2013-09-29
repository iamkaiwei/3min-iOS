//
//  TMELeftMenuViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 28/9/13.
//
//

#import "TMELeftMenuViewController.h"

@interface TMELeftMenuViewController ()

@end

@implementation TMELeftMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"]; //iOS 6+
  
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [[TMECategoryManager sharedInstance] getAllCategoriesOnSuccessBlock:^(NSInteger statusCode, id obj) {
    
  } andFailureBlock:^(NSInteger statusCode, id obj) {
    
  }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
//    self.tableView = nil;
}

#pragma mark - UITableView Datasource And Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 8; //for dummy using only.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  cell.contentView.backgroundColor = [UIColor colorWithRed:getrandom(0, 255)/255.0 green:getrandom(0, 255)/255.0 blue:getrandom(0, 255)/255.0 alpha:1];
  return cell;
}

#pragma marks - Helper
- (void)onFinishLogin:(TMEUser *)user
{
    
}

@end
