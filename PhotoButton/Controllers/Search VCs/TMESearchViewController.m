//
//  TMESearchViewController.m
//  PhotoButton
//
//  Created by Toan Slan on 1/2/14.
//
//

#import "TMESearchViewController.h"
#import "TMESearchTableViewCell.h"

static NSString * const kSearchTableViewCellIdentifier = @"TMESearchTableViewCell";

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
    
    [self.searchDisplayController.searchResultsTableView registerNib:[TMESearchTableViewCell defaultNib] forCellReuseIdentifier:[TMESearchTableViewCell kind]];
}

- (void)registerNibForTableView{
    self.arrayCellIdentifier = @[kSearchTableViewCellIdentifier];
}

#pragma mark - UITableView delegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TMESearchTableViewCell getHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TMESearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchTableViewCellIdentifier forIndexPath:indexPath];
    
    if(!cell)
        cell = [[TMESearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSearchTableViewCellIdentifier];
    
    [cell configCellWithData:self.dataArray[indexPath.row]];
    
    return cell;
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

@end
