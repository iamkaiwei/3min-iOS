//
//  TMEActivityViewControllerArrayDataSource.h
//  PhotoButton
//
//  Created by Toan Slan on 2/10/14.
//
//

#import "TMEBaseArrayDataSource.h"

typedef void (^TableViewCellHandleBlock)();

@interface TMEActivityViewControllerArrayDataSource : TMEBaseArrayDataSource

@property (nonatomic, copy) TableViewCellHandleBlock handleCellBlock;

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
cellLoadMoreIdentifier:(NSString *)aCellLoadMoreIdentifier
             paging:(BOOL)flag
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
    handleCellBlock:(TableViewCellHandleBlock)aHandleCellBlock;

@end
