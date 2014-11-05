//
//  TMEBrowserProductLoadingOperation.h
//  ThreeMin
//
//  Created by Triệu Khang on 4/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMECategory.h"
#import <KHTableViewController/KHLoadingOperationProtocol.h>

@interface TMEBrowserProductLoadingOperation : NSObject
<
KHLoadingOperationProtocol
>

@property (strong, nonatomic) TMECategory *currentCategory;

- (instancetype)initWithCategory:(TMECategory *)category andPage:(NSUInteger)page;

- (void)loadData:(void (^)(NSArray *data, NSError *error))finishBlock;

@end
