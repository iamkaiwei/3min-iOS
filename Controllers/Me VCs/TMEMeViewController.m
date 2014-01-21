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

@interface TMEMeViewController ()
<
UITableViewDelegate,
UIActionSheetDelegate,
UITableViewDataSource
>

@property (strong, nonatomic) NSArray             * arrayCellTitleSectionOne;
@property (strong, nonatomic) NSArray             * arrayCellTitleSectionTwo;
@property (strong, nonatomic) NSArray             * arrayCellTitleSectionThree;

@property (weak, nonatomic) IBOutlet UITableView  * tableViewMenu;
@end

@implementation TMEMeViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // Do any additional setup after loading the view from its nib.
  self.arrayCellTitleSectionOne = @[@"Find & Invite Friends", @"Recommended Users"];
  self.arrayCellTitleSectionTwo = @[@"My Listings", @"Offer I Made", @"Stuff I Liked"];
  self.arrayCellTitleSectionThree = @[@"Edit Profile", @"Share Settings", @"Notification Settings", @"Logout"];
  
  [self.tableViewMenu registerNib:[UINib nibWithNibName:NSStringFromClass([TMEMeTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TMEMeTableViewCell class])];
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
    case 1:
      [cell configCellWithTitle:self.arrayCellTitleSectionTwo[indexPath.row]];
      break;
    default:
      [cell configCellWithTitle:self.arrayCellTitleSectionThree[indexPath.row]];
      break;
  }
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  switch (indexPath.section) {
    case 0:
      break;
    case 1:
      break;
    default:
      if (indexPath.row == 3) {
        [self showActionSheetLogOut];
      }
      break;
  }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  switch (section) {
    case 0:
      return 2;
    case 1:
      return 3;
    default:
      return 4;
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
