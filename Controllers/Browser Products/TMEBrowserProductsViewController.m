//
//  TMEBrowerProductsViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "TMEBrowserProductsViewController.h"
#import "TMEBrowserProductsTableCell.h"

@interface TMEBrowserProductsViewController ()

@property (weak, nonatomic) IBOutlet UITableView        * tableProducts;
@property (strong, nonatomic) NSMutableArray            * arrProducts;
@property (strong, nonatomic) TMEUser                   *loginUser;

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
    self.tableProducts.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    NSString *reuseCellsIndentifier = NSStringFromClass([TMEBrowserProductsTableCell class]);
    [self.tableProducts registerNib:[UINib nibWithNibName:reuseCellsIndentifier bundle:nil] forCellReuseIdentifier:reuseCellsIndentifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onFinishLogin:) name:NOTIFICATION_FINISH_LOGIN object:nil];
    
    if ([[TMEUserManager sharedInstance] loggedUser]) {
        [self loadProductsTable];
    }
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
