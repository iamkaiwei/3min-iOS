//
//  TMELeftMenuViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 28/9/13.
//
//

#import "TMELeftMenuViewController.h"
#import "TMELeftMenuTableViewCell.h"

@interface TMELeftMenuViewController ()
<IIViewDeckControllerDelegate>

@property (strong, nonatomic) UIView *statusBarView;
@property (strong, nonatomic) TMEBaseArrayDataSource *categoryArrayDataSource;

@end

@implementation TMELeftMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getAllCategories];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self handleStatusBarAnimation];
}

- (void)registerNibForTableView{
    self.arrayCellIdentifier = @[[TMELeftMenuTableViewCell kind]];
}

- (void)setUpTableView{
    self.categoryArrayDataSource = [[TMEBaseArrayDataSource alloc] initWithItems:self.dataArray cellIdentifier:[TMELeftMenuTableViewCell kind] delegate:nil];
    
    self.tableView.dataSource = self.categoryArrayDataSource;
    [self refreshTableViewAnimated:NO];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TMECategory *category = [self.dataArray objectAtIndex:indexPath.row];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:category forKey:@"category"];
    
    [self.viewDeckController closeLeftView];
    
    UITabBarController *tabbarVC = (UITabBarController *)self.viewDeckController.centerController;
    [(UINavigationController *)tabbarVC.selectedViewController popToRootViewControllerAnimated:NO];
    tabbarVC.selectedIndex = 0;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TMECategoryDidChangeNotification object:nil userInfo:userInfo];
}

- (void)getAllCategories{
    // FIXME: This is unreliable
//    if (![self isReachable]) {
//        return;
//    }

    [[TMECategoryManager sharedManager] getAllCategoriesWithSuccess:^(NSArray *categories) {
        self.dataArray = [categories mutableCopy];
        [self setUpTableView];
    } failure:^(NSError *error) {
        [self failureBlockHandleWithError:error];
    }];
}

- (void)handleStatusBarAnimation{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.statusBarView = [[UIView alloc] initWithFrame:[[UIApplication sharedApplication] statusBarFrame]];
        [self.statusBarView setBackgroundColor:[UIColor blackColor]];
        [self.statusBarView setAlpha:0.0];
        [self.view addSubview:self.statusBarView];
        
        [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
    }
}


- (void)viewDeckController:(IIViewDeckController *)viewDeckController
           didChangeOffset:(CGFloat)offset
               orientation:(IIViewDeckOffsetOrientation)orientation
                   panning:(BOOL)panning{
    CGFloat percentVisible = offset/276;
    [self.statusBarView setAlpha:percentVisible];
    [((TMEHomeViewController *)self.viewDeckController.centerController) setStatusBarViewAlpha:percentVisible];
}

@end
