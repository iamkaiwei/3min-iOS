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

	// Add SearchTextVC
	[self addChildVC:self.searchTextVC containerView:self.view];

	[self addSearchResultVC];

	// Set SearchFilterVC as default
	[self addChildVC:self.searchFilterVC containerView:self.containerView];

	[self.searchFilterVC.view mas_makeConstraints: ^(MASConstraintMaker *make) {
	    make.edges.equalTo(self.containerView);
	}];
}

- (void)addSearchResultVC {
	[self addChildVC:self.searchResultVC containerView:self.containerView];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
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

#pragma mark - TMESearchTextVC
- (void)searchTextVC:(TMESearchTextViewController *)searchTextVC didSelectText:(NSString *)text {
	[self.searchResultVC.viewModel searchWithString:text success: ^(NSArray *arrItems) {
	    self.searchFilterVC.view.hidden = YES;
	    self.searchResultVC.view.hidden = NO;
	} failure: ^(NSError *error) {
	}];
}

- (void)searchTextVCDidCancel:(TMESearchTextViewController *)searchTextVC {
	self.searchFilterVC.view.hidden = NO;
	self.searchResultVC.view.hidden = YES;
}

@end
