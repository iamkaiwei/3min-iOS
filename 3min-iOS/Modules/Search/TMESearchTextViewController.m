//
//  TMESearchTextViewController.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/29/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMESearchTextViewController.h"
#import "TMERecentSearchManager.h"
#import "TMESingleSectionDataSource.h"
#import "UISearchBar+TMEAdditions.h"
#import <ViewUtils/ViewUtils.h>

@interface TMESearchTextViewController () <UISearchBarDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@property (nonatomic, strong) TMESingleSectionDataSource *tableViewDataSource;

@property (nonatomic, assign) BOOL bottomViewHidden;

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
    [self.searchBar tme_addDoneButton];

    [self setupTapGestureRecognizer];
    [self setupTableView];

    self.bottomViewHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Gesture
- (void)setupTapGestureRecognizer
{
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(handleTapGestureRecognizer:)];
    self.tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self hideSearchChrome];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.tableView]) {
        return NO;
    }

    return YES;
}

#pragma mark - TableView
- (void)setupTableView
{
    self.tableView.hidden = YES;

    [self.tableView registerClass:UITableViewCell.class
           forCellReuseIdentifier:UITableViewCell.kind];

    // DataSource
    self.tableViewDataSource = [[TMESingleSectionDataSource alloc] init];
    self.tableViewDataSource.sectionName = @"Recent Search";
    self.tableViewDataSource.cellIdentifier = UITableViewCell.kind;

    self.tableViewDataSource.cellConfigureBlock = ^(UITableViewCell *cell, NSString *item) {
        cell.textLabel.text = item;
    };

    __weak typeof(self) weakSelf = self;
    self.tableViewDataSource.actionBlock = ^(NSString *item) {
        weakSelf.searchBar.text = item;

        [weakSelf search];
    };

    self.tableView.dataSource = self.tableViewDataSource;
    self.tableView.delegate = self.tableViewDataSource;

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

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSArray *recentSearchTexts = [[TMERecentSearchManager sharedManager] recentSearchTexts];

    [self showSearchChrome];

    if (recentSearchTexts.count > 0) {
        self.tableViewDataSource.items = recentSearchTexts;
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    } else {
        self.tableView.hidden = YES;
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.view setNeedsUpdateConstraints];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self search];
    [self.searchBar tme_resignFirstResponderWithCancelButtonEnabled];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar setShowsCancelButton:NO animated:YES];

    [self hideSearchChrome];

    if ([self.delegate respondsToSelector:@selector(searchTextVCDidCancel:)]) {
        [self.delegate searchTextVCDidCancel:self];
    }
}

#pragma mark - Search
- (void)search
{
    [self hideSearchChrome];

    [self.searchBar setShowsCancelButton:YES animated:YES];

    [[TMERecentSearchManager sharedManager] addSearchText:self.searchBar.text];

    if ([self.delegate respondsToSelector:@selector(searchTextVC:didSelectText:)]) {
        [self.delegate searchTextVC:self didSelectText:self.searchBar.text];
    }
}

#pragma mark - Search Chrome
- (void)hideSearchChrome
{
    self.bottomViewHidden = YES;
    self.tableView.hidden = YES;

    [self.searchBar tme_resignFirstResponderWithCancelButtonEnabled];

    [self.view setNeedsUpdateConstraints];
}

- (void)showSearchChrome
{
    self.bottomViewHidden = NO;

    [self.view setNeedsUpdateConstraints];
}

#pragma mark - Constraint
- (void)updateViewConstraints
{
    [self.view mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.view.superview.mas_top);
        make.left.equalTo(self.view.superview.mas_left);
        make.right.equalTo(self.view.superview.mas_right);

        if (self.bottomViewHidden) {
            make.height.equalTo(self.searchBar.mas_height);
        } else {
            make.height.equalTo(self.view.superview.mas_height);
        }
    }];

    // TableView has "bottom space to superview" constraint removed at build time
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.bottomViewHidden) {
            make.height.mas_equalTo(0);
        } else {
            // If keyboard is shown, use smaller height
            if (self.searchBar.isFirstResponder) {
                if (IS_IPHONE_5) {
                    make.height.mas_equalTo(180);
                } else {
                    make.height.mas_equalTo(110);
                }
            } else {
                make.height.mas_equalTo(300);
            }
        }
    }];

    [super updateViewConstraints];
}

@end
