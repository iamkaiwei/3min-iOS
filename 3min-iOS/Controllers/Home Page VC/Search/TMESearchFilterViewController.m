//
//  TMESearchFilterViewController.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/29/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMESearchFilterViewController.h"
#import "TMESearchFilter.h"
#import "TMESearchFilterOnlyTableVC.h"

@interface TMESearchFilterViewController ()

@property (weak, nonatomic) IBOutlet UIView *searchFilterOnlyContainerView;
@property (nonatomic, strong) TMESearchFilterOnlyTableVC *searchFilterOnlyTableVC;

@end

@implementation TMESearchFilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.searchFilter = [[TMESearchFilter alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupSearchFilterOnlyVC];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup
- (void)setupSearchFilterOnlyVC
{
    self.searchFilterOnlyTableVC = [TMESearchFilterOnlyTableVC tme_instantiateFromStoryboardNamed:@"Search"];
    self.searchFilterOnlyTableVC.searchFilter = self.searchFilter;
    [self addChildVC:self.searchFilterOnlyTableVC containerView:self.searchFilterOnlyContainerView];

    [self.searchFilterOnlyTableVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.searchFilterOnlyContainerView);
    }];
}

#pragma mark - Action
- (IBAction)resetFiltersButtonAction:(id)sender
{

}

@end
