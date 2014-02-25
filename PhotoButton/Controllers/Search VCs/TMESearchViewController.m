//
//  TMESearchViewController.m
//  PhotoButton
//
//  Created by Toan Slan on 1/2/14.
//
//

#import "TMESearchViewController.h"
#import "TMESearchTableViewCell.h"
#import "TMEProductDetailsViewController.h"

@interface TMESearchViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UISearchBarDelegate,
UISearchDisplayDelegate,
IIViewDeckControllerDelegate
>

@end

@implementation TMESearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self disableNavigationTranslucent];
    self.dataArray = [@[] mutableCopy];
    
    self.navigationController.navigationBar.topItem.title = @"Search Product";
    self.shouldHandleKeyboardNotification = NO;
    self.tableView = self.searchDisplayController.searchResultsTableView;
    [self.searchDisplayController.searchResultsTableView registerNib:[TMESearchTableViewCell defaultNib] forCellReuseIdentifier:[TMESearchTableViewCell kind]];
}

#pragma mark - UITableView delegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TMESearchTableViewCell getHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TMESearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TMESearchTableViewCell kind] forIndexPath:indexPath];
    
    [cell configCellWithData:self.dataArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissKeyboard];
    TMEProductDetailsViewController *productDetailsController = [[TMEProductDetailsViewController alloc] init];
    productDetailsController.product = self.dataArray[indexPath.row];
    productDetailsController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:productDetailsController animated:YES];
}

#pragma mark - Search View Controller

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterListForSearchText:searchString]; // The method we made in step 7
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (void)filterListForSearchText:(NSString *)searchText
{
    [self.dataArray removeAllObjects]; //clears the array from all the string objects it might contain from the previous searches
    self.dataArray = [self arrProductsForSearchText:searchText];
}

- (NSMutableArray *)arrProductsForSearchText:(NSString *)searchText
{
    NSMutableArray *arrResultProduct = [[NSMutableArray alloc] init];
    NSArray *arrProduct = [TMEProduct MR_findAllSortedBy:@"name" ascending:YES];
    
    for (TMEProduct *product in arrProduct) {
        NSString *productNameWithoutUnicode = [[NSString alloc] initWithData:[product.name dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] encoding:NSASCIIStringEncoding];
        NSRange nameRange = [productNameWithoutUnicode rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (nameRange.location != NSNotFound && product.images.count) {
            [arrResultProduct addObject:product];
        }
    }
    
    return arrResultProduct;
}

-(void)viewWillLayoutSubviews
{
    if(self.searchDisplayController.isActive)
    {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
    [super viewWillLayoutSubviews];
}

@end
