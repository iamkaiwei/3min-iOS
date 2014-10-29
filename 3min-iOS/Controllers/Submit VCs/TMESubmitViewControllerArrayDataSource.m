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
    if (self) {
        _cellRightIdentifier = aCellRightIdentifier;
        _conversation = aConversation;
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.paging && indexPath.row == 0) {
        TMELoadMoreTableViewCell *cellLoadMore = [tableView dequeueReusableCellWithIdentifier:[TMELoadMoreTableViewCell kind]];
        
        cellLoadMore.labelLoading.text = NSLocalizedString(@"View previous message..", nil);
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
    
    if ([item.userID isEqual:[[[TMEUserManager sharedManager] loggedUser] userID]]) {
        item.userFullName = [[[TMEUserManager sharedManager] loggedUser] fullName];
        item.userAvatar = [[[TMEUserManager sharedManager] loggedUser] avatar];
        TMESubmitTableCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
        [cell configCellWithMessage:item];
        return cell;
    }
    
    item.userFullName = self.conversation.userFullname;
    item.userAvatar = self.conversation.userAvatar;
    TMESubmitTableCellRight *cell = [tableView dequeueReusableCellWithIdentifier:self.cellRightIdentifier
                                                                    forIndexPath:indexPath];
    [cell configCellWithMessage:item];
    return cell;
}

@end
