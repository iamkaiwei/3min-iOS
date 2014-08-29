//
//  TMESearchTextViewController.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/29/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMESearchTextViewController.h"
#import "TMERecentSearchManager.h"

@interface TMESearchTextViewController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TMESearchTextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.searchBar.delegate = self;

    [self setupTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    if ([TMERecentSearchManager sharedManager].recentSearchTexts.count > 0) {
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    } else {
        self.tableView.hidden = YES;
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar setShowsCancelButton:YES];
    [self.searchBar resignFirstResponder];

    [[TMERecentSearchManager sharedManager].recentSearchTexts addObject:searchBar.text];

    if ([self.delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        [self.delegate searchTextVC:self didSelectText:self.searchBar.text];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.tableView.hidden = YES;
    [self.searchBar setShowsCancelButton:NO];
}

#pragma mark - TableView
- (void)setupTableView
{
    self.tableView.hidden = YES;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    UIButton *button = [[UIButton alloc] init];

    self.tableView.tableFooterView = button;

    [button setTitle:@"Clear search history" forState:UIControlStateNormal];

    button.translatesAutoresizingMaskIntoConstraints = NO;

    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.edges.equalTo(self.tableView);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [TMERecentSearchManager sharedManager].recentSearchTexts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [TMERecentSearchManager sharedManager].recentSearchTexts[indexPath.row];

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedText = [TMERecentSearchManager sharedManager].recentSearchTexts[indexPath.row];

    self.searchBar.text = selectedText;

    self.tableView.hidden = YES;
}


@end
