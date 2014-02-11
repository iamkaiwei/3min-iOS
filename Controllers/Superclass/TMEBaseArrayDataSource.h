//
//  TMEBaseArrayDataSource.h
//  PhotoButton
//
//  Created by Toan Slan on 2/10/14.
//
//

#import <Foundation/Foundation.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item);

#define CELL_LOAD_MORE_IDENTIFIER                   @"TMELoadMoreTableViewCell"

@interface TMEBaseArrayDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
