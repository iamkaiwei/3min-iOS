//
//  TMESubmitViewControllerArrayDataSource.h
//  PhotoButton
//
//  Created by Toan Slan on 2/11/14.
//
//

#import "TMEBaseArrayDataSourceWithLoadMore.h"

typedef void (^TableViewCellRightConfigureBlock)(id cell, id item);

@interface TMESubmitViewControllerArrayDataSource : TMEBaseArrayDataSourceWithLoadMore

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
cellRightIdentifier:(NSString *)aCellRightIdentifier
       conversation:(TMEConversation *)aConversation
             paging:(BOOL)flag;

@end
