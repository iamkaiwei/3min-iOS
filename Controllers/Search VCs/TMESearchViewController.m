//
//  TMESearchViewController.m
//  PhotoButton
//
//  Created by Toan Slan on 1/2/14.
//
//

#import "TMESearchViewController.h"

static NSString * const productSelected = @"productSelected";
static NSString * const userSelected = @"userSelected";

@interface TMESearchViewController ()
<UITableViewDataSource,
UITableViewDelegate,
UISearchBarDelegate,
UISearchDisplayDelegate
>

@property (strong, nonatomic) NSString *state;

@end

@implementation TMESearchViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
    self.edgesForExtendedLayout = UIRectEdgeNone;
  }
  
  self.state = productSelected;
  [self loadNavigationItem];
}

- (void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  
  [self unregisterForKeyboardNotifications];
}

- (UIBarButtonItem *)leftNavigationButtonProducts
{
  UIImage *leftButtonBackgroundNormalImage = [UIImage oneTimeImageWithImageName:@"btn_products" isIcon:YES];
  UIImage *leftButtonBackgroundSelectedImage = [UIImage oneTimeImageWithImageName:@"btn_products_selected" isIcon:YES];
  UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, 75, 40)];
  [leftButton addTarget:self action:@selector(onProductsButton:) forControlEvents:UIControlEventTouchUpInside];
  [leftButton setBackgroundImage:leftButtonBackgroundNormalImage forState:UIControlStateNormal];
  [leftButton setBackgroundImage:leftButtonBackgroundSelectedImage forState:UIControlStateHighlighted];
  [leftButton setBackgroundImage:leftButtonBackgroundSelectedImage forState:UIControlStateSelected];
  
  if (self.state == productSelected) {
    leftButton.selected = YES;
  }
  
  return [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (UIBarButtonItem *)rightNavigationButtonUsers
{
  UIImage *rightButtonBackgroundNormalImage = [UIImage oneTimeImageWithImageName:@"btn_users" isIcon:YES];
  UIImage *rightButtonBackgroundSelectedImage = [UIImage oneTimeImageWithImageName:@"btn_users_selected" isIcon:YES];
  UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, 75, 40)];
  [rightButton addTarget:self action:@selector(onUsersButton:) forControlEvents:UIControlEventTouchUpInside];
  [rightButton setBackgroundImage:rightButtonBackgroundNormalImage forState:UIControlStateNormal];
  [rightButton setBackgroundImage:rightButtonBackgroundSelectedImage forState:UIControlStateHighlighted];
  [rightButton setBackgroundImage:rightButtonBackgroundSelectedImage forState:UIControlStateSelected];
  
  if (self.state == userSelected) {
    rightButton.selected = YES;
  }
  
  return [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)onProductsButton:(id)sender{
  self.state = productSelected;
  [self loadNavigationItem];
}

- (void)onUsersButton:(id)sender{
  self.state = userSelected;
  [self loadNavigationItem];
}

- (void)loadNavigationItem{
  self.navigationItem.leftBarButtonItem = [self leftNavigationButtonProducts];
  self.navigationItem.rightBarButtonItem = [self rightNavigationButtonUsers];
}

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

- (void)onKeyboardWillShowNotification:(NSNotification *)sender{
  DLog(@"OK");
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller{
  [self.navigationController setNavigationBarHidden:NO];
}

@end
