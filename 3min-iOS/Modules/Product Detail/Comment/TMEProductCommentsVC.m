//
//  TMEProductCommentsVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 9/22/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductCommentsVC.h"
#import "TMEProductCommentViewModel.h"
#import "TMEProductCommentViewModel.h"
#import "TMESingleSectionDataSource.h"
#import "TMEProductCommentCell.h"
#import "TMEProductComment.h"

@interface TMEProductCommentsVC () <UITableViewDelegate>

@property (nonatomic, strong) TMEProductCommentViewModel *viewModel;
@property (nonatomic, strong) FBKVOController *viewModelKVOController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) TMEProductCommentCell *prototypeCell;
@property (nonatomic, strong) TMESingleSectionDataSource *dataSource;

@end

@implementation TMEProductCommentsVC

- (void)awakeFromNib
{
    self.title = @"Comments";
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupTableView];
    [self configureViewModel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ViewModel
- (void)configureViewModel
{
    self.viewModel = [[TMEProductCommentViewModel alloc] initWithProduct:self.product];
    self.viewModelKVOController = [FBKVOController controllerWithObserver:self];
    [self.viewModelKVOController observe:self.view
                                 keyPath:@"productComments"
                                 options:NSKeyValueObservingOptionNew
                                   block:^(id observer, id object, NSDictionary *change)
    {
        typeof(self) innerSelf = observer;
        [innerSelf.tableView reloadData];
    }];

    [self.viewModel pullProductComments];
}

#pragma mark - TableView
- (void)setupTableView
{
    self.tableView.delegate = self;

    // DataSource
    self.dataSource = [[TMESingleSectionDataSource alloc] init];
    self.dataSource.cellIdentifier = [TMEProductCommentCell kind];
    self.dataSource.cellConfigureBlock = ^(TMEProductCommentCell *cell, TMEProductComment *comment) {
        [cell configureForModel:comment];
    };

    self.tableView.dataSource = self.dataSource;
}

- (TMEProductCommentCell *)prototypeCell
{
    if (!_prototypeCell) {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:[TMEProductCommentCell kind]];
    }

    return _prototypeCell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMEProductComment *comment = self.dataSource.items[indexPath.row];
    [self.prototypeCell configureForModel:comment];
    
    [self.prototypeCell layoutIfNeeded];
    [self.prototypeCell updateConstraintsIfNeeded];

    return [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
