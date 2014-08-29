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

#import "TMESearchFilter.h"


@interface TMESearchPageContentViewController () <TMESearchTextViewController>

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, strong) TMESearchTextViewController *searchTextVC;
@property (nonatomic, strong) TMESearchFilterViewController *searchFilterVC;
@property (nonatomic, strong) UIViewController *searchResultVC;

@property (nonatomic, strong) UIViewController *currentChildVC;

@end

@implementation TMESearchPageContentViewController

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

    // Add SearchTextVC
    [self addChildVC:self.searchTextVC containerView:self.view];

    // Set SearchFilterVC as default
    [self addChildVC:self.searchFilterVC containerView:self.containerView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ChildVC
- (TMESearchTextViewController *)searchTextVC
{
    if (!_searchTextVC) {
        _searchTextVC = [[TMESearchTextViewController alloc] init];
        _searchTextVC.delegate = self;
    }

    return _searchTextVC;
}

- (TMESearchFilterViewController *)searchFilterVC
{
    if (!_searchFilterVC) {
        _searchFilterVC = [[TMESearchFilterViewController alloc] init];
    }

    return _searchFilterVC;
}

- (UIViewController *)searchResultVC
{
    if (!_searchResultVC) {
        _searchResultVC = [[UIViewController alloc] init];
    }

    return _searchResultVC;
}

- (void)addChildVC:(UIViewController *)childVC containerView:(UIView *)containerView
{
    [self addChildViewController:childVC];
    childVC.view.frame = containerView.bounds;
    [containerView addSubview:childVC.view];
    [childVC didMoveToParentViewController:self];

    self.currentChildVC = childVC;
}

- (void)removeChildVC:(UIViewController *)childVC
{
    [childVC willMoveToParentViewController:nil];
    [childVC.view removeFromSuperview];
    [childVC removeFromParentViewController];
}

#pragma mark - TMESearchTextVC
- (void)searchTextVC:(TMESearchTextViewController *)searchTextVC didSelectText:(NSString *)text
{

}

@end
