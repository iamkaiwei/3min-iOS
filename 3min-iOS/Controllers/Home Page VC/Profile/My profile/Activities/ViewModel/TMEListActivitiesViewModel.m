//
//  TMEListActivitiesViewModel.m
//  ThreeMin
//
//  Created by Triệu Khang on 1/10/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEListActivitiesViewModel.h"

@interface TMEListActivitiesViewModel()

@property (strong, nonatomic) NSMutableArray *arrItems;

@end


@implementation TMEListActivitiesViewModel

- (NSInteger)numberOfItems {
    return [self.arrItems count];
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 0 || indexPath.row >= self.arrItems.count) {
        return nil;
    }
    return self.arrItems[indexPath.row];
}

- (void)reloadWithDoneBlock:(ViewModelDoneBlock)doneBlock {
    [self pullRemoteDoneBlock:doneBlock];
}

- (void)pullRemoteWithPage:(NSUInteger)page doneBlock:(ViewModelDoneBlock)doneBlock {
    [self pullRemoteDoneBlock:doneBlock];
}

- (void)pullRemoteDoneBlock:(ViewModelDoneBlock)doneBlock {
	[[TMEActivityManager sharedManager] getActivitiesWithSuccess: ^(NSArray *models) {
        self.arrItems = [models mutableCopy];
	    if (doneBlock) {
	        doneBlock(models, nil);
		}
	} failure: ^(NSError *error) {
	    if (doneBlock) {
	        doneBlock(nil, error);
		}
	}];
}

@end
