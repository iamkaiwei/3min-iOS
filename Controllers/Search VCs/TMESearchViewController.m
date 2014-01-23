//
//  TMESearchViewController.m
//  PhotoButton
//
//  Created by Toan Slan on 1/2/14.
//
//

#import "TMESearchViewController.h"

//typedef enum {
//  SEARCH_BY_PRODUCT,
//  SEARCH_BY_USER
//}SEARCH_BY;

@interface TMESearchViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UISearchBarDelegate,
UISearchDisplayDelegate
>

//@property (assign, nonatomic) SEARCH_BY state;

@end

@implementation TMESearchViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  [self disableNavigationTranslucent];
  self.navigationController.navigationBar.topItem.title = @"Search Product";
//  self.state = SEARCH_BY_PRODUCT;
  self.shouldHandleKeyboardNotification = NO;
//  [self loadNavigationItem];
}

//#pragma mark - Navigation Bar Buttons
//
//- (UIBarButtonItem *)leftNavigationButtonProducts
//{
//  UIImage *leftButtonBackgroundNormalImage = [UIImage oneTimeImageWithImageName:@"btn_products" isIcon:YES];
//  UIImage *leftButtonBackgroundSelectedImage = [UIImage oneTimeImageWithImageName:@"btn_products_selected" isIcon:YES];
//  UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, 75, 40)];
//  [leftButton addTarget:self action:@selector(onProductsButton:) forControlEvents:UIControlEventTouchUpInside];
//  [leftButton setBackgroundImage:leftButtonBackgroundNormalImage forState:UIControlStateNormal];
//  [leftButton setBackgroundImage:leftButtonBackgroundSelectedImage forState:UIControlStateHighlighted];
//  [leftButton setBackgroundImage:leftButtonBackgroundSelectedImage forState:UIControlStateSelected];
//  
//  if (self.state == SEARCH_BY_PRODUCT) {
//    leftButton.selected = YES;
//  }
//  
//  return [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//}

//- (UIBarButtonItem *)rightNavigationButtonUsers
//{
//  UIImage *rightButtonBackgroundNormalImage = [UIImage oneTimeImageWithImageName:@"btn_users" isIcon:YES];
//  UIImage *rightButtonBackgroundSelectedImage = [UIImage oneTimeImageWithImageName:@"btn_users_selected" isIcon:YES];
//  UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, 75, 40)];
//  [rightButton addTarget:self action:@selector(onUsersButton:) forControlEvents:UIControlEventTouchUpInside];
//  [rightButton setBackgroundImage:rightButtonBackgroundNormalImage forState:UIControlStateNormal];
//  [rightButton setBackgroundImage:rightButtonBackgroundSelectedImage forState:UIControlStateHighlighted];
//  [rightButton setBackgroundImage:rightButtonBackgroundSelectedImage forState:UIControlStateSelected];
//  
//  if (self.state == SEARCH_BY_USER) {
//    rightButton.selected = YES;
//  }
//  
//  return [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//}
//
//- (void)loadNavigationItem{
//  self.navigationItem.leftBarButtonItem = [self leftNavigationButtonProducts];
//  self.navigationItem.rightBarButtonItem = [self rightNavigationButtonUsers];
//}

//#pragma mark - Actions
//
//- (void)onProductsButton:(id)sender{
//  self.state = SEARCH_BY_PRODUCT;
//  [self loadNavigationItem];
//}
//
//- (void)onUsersButton:(id)sender{
//  self.state = SEARCH_BY_USER;
//  [self loadNavigationItem];
//}

#pragma mark - UITableView delegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = [[UITableViewCell alloc] init];
  return cell;
}

#pragma mark - Search View Controller

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller{
  
}

#pragma mark - Keyboard notifications

- (void)onKeyboardWillShowNotification:(NSNotification *)sender{
  DLog(@"OK");
}

@end
