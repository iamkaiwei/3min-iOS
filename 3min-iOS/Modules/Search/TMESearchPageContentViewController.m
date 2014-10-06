//
//  TMESearchPageContentViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMESearchPageContentViewController.h"
#import "TMESearchFilterViewController.h"
#import "TMESearchTextViewController.h"
#import "TMESearchResultViewController.h"

#import "TMESearchFilter.h"

#import "TMESearchNetworkClient.h"


@interface TMESearchPageContentViewController () <TMESearchTextViewController>

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, strong) TMESearchTextViewController *searchTextVC;
@property (nonatomic, strong) TMESearchFilterViewController *searchFilterVC;
@property (nonatomic, strong) TMESearchResultViewController *searchResultVC;

@property (nonatomic, strong) UIViewController *currentChildVC;
@end

@implementation TMESearchPageContentViewController

- (void)viewDidLoad {
	[super viewDidLoad];

    [self setupChildVC];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Setup
- (void)setupChildVC
{
    // Add SearchTextVC
	[self addChildVC:self.searchTextVC containerView:self.view];

	[self addChildVC:self.searchResultVC containerView:self.containerView];

	// Set SearchFilterVC as default
	[self addChildVC:self.searchFilterVC containerView:self.containerView];

	[self.searchFilterVC.view mas_makeConstraints: ^(MASConstraintMaker *make) {
	    make.edges.equalTo(self.containerView);
	}];
}

#pragma mark - ChildVC
- (TMESearchTextViewController *)searchTextVC {
	if (!_searchTextVC) {
		_searchTextVC = [[TMESearchTextViewController alloc] init];
		_searchTextVC.delegate = self;
	}

	return _searchTextVC;
}

- (TMESearchFilterViewController *)searchFilterVC {
	if (!_searchFilterVC) {
		_searchFilterVC = [[TMESearchFilterViewController alloc] init];
	}

	return _searchFilterVC;
}

- (TMESearchResultViewController *)searchResultVC {
	if (!_searchResultVC) {
		_searchResultVC = [[TMESearchResultViewController alloc] init];
	}

	return _searchResultVC;
}

#pragma mark - TMESearchTextVCDelegate
- (void)searchTextVC:(TMESearchTextViewController *)searchTextVC didSelectText:(NSString *)text {
    [SVProgressHUD show];
	[self.searchResultVC.viewModel searchWithString:text success: ^(NSArray *arrItems) {
        [SVProgressHUD dismiss];
	    [self showSearchResultVC];
	} failure: ^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:nil];
	}];
}

- (void)searchTextVCDidCancel:(TMESearchTextViewController *)searchTextVC {
	[self showSearchFilterVC];
}

#pragma mark - Helper
- (void)showSearchFilterVC
{
    [self showChildVC:self.searchFilterVC];
}

- (void)showSearchResultVC
{
    [self showChildVC:self.searchResultVC];
}

- (void)showChildVC:(UIViewController *)childVC
{
    UIViewController *showVC, *hideVC;
    for (UIViewController *vc in @[ self.searchResultVC, self.searchFilterVC ]) {
        if (vc == childVC) {
            showVC = vc;
        } else {
            hideVC = vc;
        }
    }

    showVC.view.alpha = 0;
    hideVC.view.alpha = 1;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        showVC.view.alpha = 1;
        hideVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        showVC.view.hidden = NO;
        hideVC.view.hidden = YES;
    }];
}

@end
