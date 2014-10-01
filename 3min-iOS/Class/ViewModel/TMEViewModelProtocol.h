//
//  TMEViewModelProtocol.h
//  ThreeMin
//
//  Created by Triệu Khang on 1/10/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ViewModelDoneBlock)(NSArray *items, NSError *error);

@protocol TMEViewModelProtocol <NSObject>

/**
 *  For pagenation
 *
 *  @param page      page index
 *  @param doneBlock onDone block
 */
- (void)pullRemoteWithPage:(NSUInteger)page doneBlock:(ViewModelDoneBlock)doneBlock;

/**
 *  Return the number of items in view model
 *
 *  @return numberOfItems
 */
- (NSInteger)numberOfItems;

/**
 *  Return item at specified indexpath, nil if the indexPath is invalue
 *
 *  @param indexPath indexPath of items
 *
 *  @return the items
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  It will be called after get the response
 *
 *  @param doneBlock doneBlock
 */
- (void)reloadWithDoneBlock:(ViewModelDoneBlock)doneBlock;

@end
