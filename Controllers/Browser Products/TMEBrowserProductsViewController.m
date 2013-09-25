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
    self.title = @"Browser Products";
    // Do any additional setup after loading the view from its nib.
    
    NSString *reuseCellsIndentifier = NSStringFromClass([TMEBrowserProductsTableCell class]);
    [self.tableProducts registerNib:[UINib nibWithNibName:reuseCellsIndentifier bundle:nil] forCellReuseIdentifier:reuseCellsIndentifier];
    
    self.arrProducts = [[[TMEProductsManager sharedInstance] fakeGetAllStoredProducts] mutableCopy];
    
    [[TMEProductsManager sharedInstance] getAllProductsOnSuccessBlock:^(NSInteger statusCode, id obj) {
        
        if ([obj isKindOfClass:[NSArray class]]) {
            self.arrProducts = [[TMEProduct arrayProductsFromArray:obj] mutableCopy];
            [self.tableProducts reloadData];
        }
        
    } andFailureBlock:^(NSInteger statusCode, id obj) {
        
    }];
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
    
    if (!cell) {
        cell = (TMEBrowserProductsTableCell *)[UINib nibWithNibName:cellIndentifier bundle:nil];
    }
    
    TMEProduct *product = [self.arrProducts objectAtIndex:indexPath.row];
    [cell configCellWithProduct:product];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TMEBrowserProductsTableCell getHeight];
}

@end
