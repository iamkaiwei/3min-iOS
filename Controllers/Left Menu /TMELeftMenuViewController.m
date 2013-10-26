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

- (NSArray *)arrayCategories
{
    if (!_arrayCategories) {
        
        NSMutableArray *categories = [NSMutableArray array];
        
        NSArray *categoriesName = @[@"Books", @"Design_art", @"Follwing", @"For-her", @"For-him", @"house", @"Popular"];
        for (NSString *categoryName in categoriesName) {
            TMECategory *category = [TMECategory MR_createEntity];
            category.name = categoryName;
            category.photo_url = categoryName;
            [categories addObject:category];
        }
        
        _arrayCategories = categories;
    }
    
    return _arrayCategories;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[TMELeftMenuTableViewCell defaultNib] forCellReuseIdentifier:NSStringFromClass([TMELeftMenuTableViewCell class])]; //iOS 6+
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[TMECategoryManager sharedInstance] getAllCategoriesOnSuccessBlock:^(NSInteger statusCode, id obj) {
//        
//    } andFailureBlock:^(NSInteger statusCode, id obj) {
//        
//    }];
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

@end
