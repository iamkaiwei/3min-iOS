//
//  TMESubmitViewControllerArrayDataSource.m
//  PhotoButton
//
//  Created by Toan Slan on 2/11/14.
//
//

#import "TMESubmitViewControllerArrayDataSource.h"
#import "TMELoadMoreTableViewCell.h"
#import "TMESubmitTableCell.h"
#import "TMESubmitTableCellRight.h"

@interface TMESubmitViewControllerArrayDataSource()

@property (nonatomic, copy) TableViewCellRightConfigureBlock configureCellRightBlock;
@property (nonatomic, strong) TMEConversation *conversation;
@property (nonatomic, strong) NSString *cellRightIdentifier;

@end

@implementation TMESubmitViewControllerArrayDataSource

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
cellRightIdentifier:(NSString *)aCellRightIdentifier
       conversation:(TMEConversation *)aConversation
             paging:(BOOL)flag{
    self = [super initWithItems:anItems cellIdentifier:aCellIdentifier paging:flag handleCellBlock:nil];
    if (self) {;
        self.cellRightIdentifier = aCellRightIdentifier;
        self.conversation = aConversation;
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.paging && indexPath.row == 0) {
        TMELoadMoreTableViewCell *cellLoadMore = [tableView dequeueReusableCellWithIdentifier:[TMELoadMoreTableViewCell kind]];
        
        cellLoadMore.labelLoading.text = @"View previous message..";
        [cellLoadMore.labelLoading setWidth:200];
        [cellLoadMore.labelLoading alignHorizontalCenterToView:tableView];
        
        return cellLoadMore;
    }
    TMEReply *item;
    
    if (self.paging) {
        item = self.items[indexPath.row - 1];
    }
    else {
        item = [self itemAtIndexPath:indexPath];
    }
    
    if ([item.user_id isEqual:[[[TMEUserManager sharedInstance] loggedUser] id]]) {
        item.user_full_name = [[[TMEUserManager sharedInstance] loggedUser] fullname];
        item.user_avatar = [[[TMEUserManager sharedInstance] loggedUser] photo_url];
        TMESubmitTableCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
        [cell configCellWithMessage:item];
        return cell;
    }
    
    item.user_full_name = self.conversation.user_full_name;
    item.user_avatar = self.conversation.user_avatar;
    TMESubmitTableCellRight *cell = [tableView dequeueReusableCellWithIdentifier:self.cellRightIdentifier
                                                                    forIndexPath:indexPath];
    [cell configCellWithMessage:item];
    return cell;
}

@end
