//
//  TMEBrowerProductsViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "TMEBrowserProductsViewController.h"
#import "TMEBrowserProductsTableCell.h"

#define ANIMATION_DURATION 0.3

typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;

@interface TMEBrowserProductsViewController ()
<
UIScrollViewDelegate
>

@property (weak, nonatomic) IBOutlet UITableView        * tableProducts;
@property (strong, nonatomic) NSMutableArray            * arrProducts;
@property (strong, nonatomic) TMEUser                   *loginUser;

@property (nonatomic, assign) CGPoint scrollViewLastContentOffset;

@end

@implementation TMEBrowserProductsViewController

- (NSMutableArray *)arrProducts{
    if (_arrProducts) {
        return _arrProducts;
    }
    
    return [@[] mutableCopy];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"";
    self.navigationController.navigationBar.topItem.title = @"Broswer Products";
    
    NSString *reuseCellsIndentifier = NSStringFromClass([TMEBrowserProductsTableCell class]);
    [self.tableProducts registerNib:[UINib nibWithNibName:reuseCellsIndentifier bundle:nil] forCellReuseIdentifier:reuseCellsIndentifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onFinishLogin:) name:NOTIFICATION_FINISH_LOGIN object:nil];
    
    if ([[TMEUserManager sharedInstance] loggedUser]) {
        [self loadProductsTable];
    }
    
    self.scrollViewLastContentOffset = CGPointMake(0, 44);

}

#pragma marks - Hide and show navigation bar

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (/* scrollView.decelerating
         && */ scrollView.contentOffset.y > 0
        && self.scrollViewLastContentOffset.y < scrollView.contentOffset.y) {
        [self hideNavbar];
    }
    else if (self.scrollViewLastContentOffset.y > scrollView.contentOffset.y
             && scrollView.contentOffset.y + scrollView.height < scrollView.contentSize.height) {
        [self showNavbar];
    }
    
    self.scrollViewLastContentOffset = scrollView.contentOffset;
}


#pragma mark - Top & Bottom bar animation

- (BOOL)hideNavbar
{
    CGFloat deltaHeight = self.navigationController.navigationBar.height;
    if (self.navigationController.navigationBar.top == -deltaHeight)
        return NO;
    
    self.tableProducts.height += 44;
    
    [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.tableProducts.top = -deltaHeight;
        self.navigationController.navigationBar.top = -deltaHeight;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [[self navigationController] setNavigationBarHidden:YES animated:NO];
        } completion:nil];
    }];
    return YES;
}

- (BOOL)showNavbar
{
    if (self.navigationController.navigationBar.top == 0)
        return NO;
    
    self.tableProducts.height -= 44;
    self.tableProducts.top =  0;
    
    [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.navigationController.navigationBar.top = 0;
        [[self navigationController] setNavigationBarHidden:NO animated:NO];
    } completion:nil];
    return YES;
}

#pragma marks - UITableView delegate

#pragma marks - UITableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrProducts.count;
}

- (TMEBrowserProductsTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIndentifier = NSStringFromClass([TMEBrowserProductsTableCell class]);
    TMEBrowserProductsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    TMEProduct *product = [self.arrProducts objectAtIndex:indexPath.row];
    [cell configCellWithProduct:product];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TMEBrowserProductsTableCell getHeight];
}

- (void)onFinishLogin:(TMEUser *)user
{
    [self loadProductsTable];
}

- (void)loadProductsTable{
    [SVProgressHUD dismiss];
    
    [SVProgressHUD showWithStatus:@"Loading content..." maskType:SVProgressHUDMaskTypeGradient];
    [[TMEProductsManager sharedInstance] getAllProductsOnSuccessBlock:^(NSArray *arrProducts) {
        
        self.arrProducts = [arrProducts mutableCopy];
        [self.tableProducts reloadData];
        
        [SVProgressHUD dismiss];
        
    } andFailureBlock:^(NSInteger statusCode, id obj) {
        [SVProgressHUD dismiss];
    }];
}

@end
