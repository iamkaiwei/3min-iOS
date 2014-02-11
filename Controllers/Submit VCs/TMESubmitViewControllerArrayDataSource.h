//
//  TMESubmitViewControllerArrayDataSource.h
//  PhotoButton
//
//  Created by Toan Slan on 2/11/14.
//
//

#import "TMEActivityViewControllerArrayDataSource.h"

typedef void (^TableViewCellRightConfigureBlock)(id cell, id item);

@interface TMESubmitViewControllerArrayDataSource : TMEActivityViewControllerArrayDataSource

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
cellRightIdentifier:(NSString *)aCellRightIdentifier
       conversation:(TMEConversation *)aConversation
             paging:(BOOL)flag;

@end
