//
//  TMEMeViewController.m
//  PhotoButton
//
//  Created by Toan Slan on 1/2/14.
//
//

#import "TMEMeViewController.h"
#import "TMEMeTableViewCell.h"
#import "TMEMyListingViewController.h"
#import "TMEOfferedViewController.h"
#import "TMELikedViewController.h"

@interface TMEMeViewController ()
<
UIActionSheetDelegate
>

@property (weak, nonatomic) IBOutlet UIImageView *imageViewAvatar;
@property (strong, nonatomic) NSArray             * arrayCellTitleSectionOne;
@property (strong, nonatomic) NSArray             * arrayCellTitleSectionTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelUsername;
@property (weak, nonatomic) IBOutlet UILabel *labelUserEmail;

@end

@implementation TMEMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.arrayCellTitleSectionOne = @[NSLocalizedString(@"My Listings", nil), NSLocalizedString(@"Offer I Made", nil), NSLocalizedString(@"Stuff I Liked", nil)];
    self.arrayCellTitleSectionTwo = @[NSLocalizedString(@"Log out", nil)];
    [self configView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setEdgeForExtendedLayoutAll];
    self.navigationController.navigationBar.topItem.title = [[TMEUserManager sharedManager] loggedUser].fullname;
}

- (void)configView{
    TMEUser *loggedUser = [[TMEUserManager sharedManager] loggedUser];
    
    [self.imageViewAvatar setImageWithURL:[NSURL URLWithString:loggedUser.photo_url]];
    self.imageViewAvatar.layer.cornerRadius = 70;
    
    self.labelUsername.text = loggedUser.fullname;
    [self.labelUsername sizeToFitKeepHeight];
    [self.labelUsername alignHorizontalCenterToView:self.view];
    
    self.labelUserEmail.text = loggedUser.email;
    [self.labelUserEmail sizeToFitKeepHeight];
    [self.labelUserEmail alignHorizontalCenterToView:self.view];
    
    [self.tableView reloadData];
    self.tableView.height = self.tableView.contentSize.height;
    [((UIScrollView *)self.view) autoAdjustScrollViewContentSize];
}

- (void)registerNibForTableView{
    self.arrayCellIdentifier = @[[TMEMeTableViewCell kind]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TMEMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMEMeTableViewCell class]) forIndexPath:indexPath];
    
    if (!indexPath.section) {
        [cell configCellWithTitle:self.arrayCellTitleSectionOne[indexPath.row]];
        return cell;
    }
    
    [cell configCellWithTitle:self.arrayCellTitleSectionTwo[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!indexPath.section) {
        NSArray *viewControllers = @[[TMEMyListingViewController new], [TMEOfferedViewController new], [TMELikedViewController new]];
        [self.navigationController pushViewController:viewControllers[indexPath.row] animated:YES];
        return;
    }
    [self showActionSheetLogOut];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [@[@3,@1][section] integerValue];
}

- (void)showActionSheetLogOut{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Are you sure you want to log out?", nil)
                                                       delegate:self
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:NSLocalizedString(@"Log out", nil)
                                              otherButtonTitles:NSLocalizedString(@"Cancel", nil), nil];
    [sheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (!buttonIndex) {
        if (![self isReachable]) {
            return;
        }

        //FIXME: Fix this stuff
        /*
        [[TMEUserManager sharedManager] logOut];
        UITabBarController *tabBarController = (UITabBarController *)self.deckController.centerController;
        tabBarController.selectedIndex = 0;
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:LAST_LOGIN_TIMESTAMP_STORED_KEY];
         */
    }
}

@end
