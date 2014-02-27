//
//  TMEBaseTableViewController.h
//  PhotoButton
//
//  Created by Triệu Khang on 12/9/13.
//
//

#import <UIKit/UIKit.h>
#import "TMEBaseViewController.h"

@interface TMEBaseTableViewController : TMEBaseViewController <UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *lblInstruction;
@property (assign, nonatomic) BOOL paging;
@property (assign, nonatomic) BOOL registerLoadMoreCell;
@property (assign, nonatomic) NSInteger currentPage;
@property (nonatomic, strong) NSArray *arrayCellIdentifier;
@property (nonatomic, strong) NSMutableArray *dataArray;

- (void)registerNibForTableView;
- (void)deselectAllCellsAnimated:(BOOL)animated;
- (void)fadeInTableView;
- (void)fadeOutTableView;
- (void)fadeInTableViewOnCompletion:(void (^)(BOOL finished))completion;
- (void)fadeOutTableViewOnCompletion:(void (^)(BOOL finished))completion;

- (void)refreshTableViewAnimated:(BOOL)animated;
- (void)refreshTableViewOnCompletion:(void (^)(BOOL finished))completion;
- (void)handlePagingWithResponseArray:(NSArray *)array currentPage:(NSInteger)page;
- (BOOL)isReachable;
- (void)finishLoading;

@end
