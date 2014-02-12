//
//  TMEMeViewController.m
//  PhotoButton
//
//  Created by Toan Slan on 1/2/14.
//
//

#import "TMEMeViewController.h"
#import "TMEMeTableViewCell.h"
#import "TMEMeTableViewCellBackgroundView.h"
#import "TMEMyListingViewController.h"

@interface TMEMeViewController ()
<
UITableViewDelegate,
UIActionSheetDelegate,
UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UIImageView *imageViewAvatar;
@property (strong, nonatomic) NSArray             * arrayCellTitleSectionOne;
@property (strong, nonatomic) NSArray             * arrayCellTitleSectionTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelUsername;
@property (weak, nonatomic) IBOutlet UILabel *labelUserEmail;

@property (weak, nonatomic) IBOutlet UITableView  * tableViewMenu;
@end

@implementation TMEMeViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // Do any additional setup after loading the view from its nib.
  self.arrayCellTitleSectionOne = @[@"My Listings", @"Offer I Made", @"Stuff I Liked"];
  self.arrayCellTitleSectionTwo = @[@"Logout"];
  
  TMEUser *loggedUser = [[TMEUserManager sharedInstance] loggedUser];
  
  [self.imageViewAvatar setImageWithURL:[NSURL URLWithString:loggedUser.photo_url]];
  self.imageViewAvatar.layer.cornerRadius = 70;
  
  self.labelUsername.text = loggedUser.fullname;
  [self.labelUsername sizeToFitKeepHeight];
  [self.labelUsername alignHorizontalCenterToView:self.view];
  
  self.labelUserEmail.text = loggedUser.email;
  [self.labelUserEmail sizeToFitKeepHeight];
  [self.labelUserEmail alignHorizontalCenterToView:self.view];
  
  [self disableNavigationTranslucent];
  
  [self.tableViewMenu registerNib:[UINib nibWithNibName:NSStringFromClass([TMEMeTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TMEMeTableViewCell class])];
  
  [((UIScrollView *)self.view) setContentSize:CGSizeMake(CGRectGetWidth([[UIScreen mainScreen]bounds]), 465)];
  
}

- (void)viewWillAppear:(BOOL)animated{
  
  [super viewWillAppear:animated];
  self.navigationController.navigationBar.topItem.title = [[TMEUserManager sharedInstance] loggedUser].fullname;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  TMEMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMEMeTableViewCell class]) forIndexPath:indexPath];
  
  switch (indexPath.section) {
    case 0:
      [cell configCellWithTitle:self.arrayCellTitleSectionOne[indexPath.row]];
      break;
    default:
      [cell configCellWithTitle:self.arrayCellTitleSectionTwo[indexPath.row]];
      break;
  }
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  switch (indexPath.section) {
    case 0:
      if (indexPath.row == 0) {
        [self.navigationController pushViewController:[[TMEMyListingViewController alloc] init] animated:YES];
      }
      break;
    default:
      if (indexPath.row == 0) {
        [self showActionSheetLogOut];
      }
      break;
  }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  switch (section) {
    case 0:
      return 3;
    default:
      return 1;
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return [TMEMeTableViewCell getHeight];
}

- (void)showActionSheetLogOut{
  UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Are you sure you want to log out?"
                                                     delegate:self
                                            cancelButtonTitle:nil
                                       destructiveButtonTitle:@"Log out"
                                            otherButtonTitles:@"Cancel", nil];
  [sheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
  switch (buttonIndex) {
    case 0:
      if (![TMEReachabilityManager isReachable]) {
        [SVProgressHUD showErrorWithStatus:@"No connection!"];
        return;
      }
      [[TMEUserManager sharedInstance] logOut];
      [[TMEFacebookManager sharedInstance] showLoginView];
      [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:LAST_LOGIN_TIMESTAMP_STORED_KEY];
      break;
      
    default:
      break;
  }
}

@end
