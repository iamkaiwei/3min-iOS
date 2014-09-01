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

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@property (nonatomic, strong) NSArray *recentSearchTexts;

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

    [self setupTapGestureRecognizer];
    [self setupTableView];
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.view.superview.mas_top);
        make.left.equalTo(self.view.superview.mas_left);
        make.right.equalTo(self.view.superview.mas_right);

        if (self.tableView.hidden) {
            make.height.equalTo(self.searchBar.mas_height);
        } else {
            make.height.equalTo(self.view.superview.mas_height);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Gesture
- (void)setupTapGestureRecognizer
{
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hanleTapGestureRecognizer:)];
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)hanleTapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self.searchBar resignFirstResponder];
}

#pragma mark - TableView
- (void)setupTableView
{
    self.tableView.hidden = YES;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UITableViewCell.kind];

    // Footer
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"Clear search history" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];

    [button addTarget:self action:@selector(clearButtonAction:) forControlEvents:UIControlEventTouchUpInside];


    self.tableView.tableFooterView = button;
}

- (void)clearButtonAction:(id)sender
{
    [[TMERecentSearchManager sharedManager] clear];
    self.tableView.hidden = YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recentSearchTexts.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Recent Search";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCell.kind];

    cell.textLabel.text = self.recentSearchTexts[indexPath.row];

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedText = self.recentSearchTexts[indexPath.row];

    self.searchBar.text = selectedText;

    self.tableView.hidden = YES;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.recentSearchTexts = [[TMERecentSearchManager sharedManager] recentSearchTexts];

    if (self.recentSearchTexts.count > 0) {
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

    self.tableView.hidden = YES;

    [[TMERecentSearchManager sharedManager] addSearchText:searchBar.text];

    if ([self.delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        [self.delegate searchTextVC:self didSelectText:self.searchBar.text];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.tableView.hidden = YES;
    [self.searchBar setShowsCancelButton:NO];
}

@end
