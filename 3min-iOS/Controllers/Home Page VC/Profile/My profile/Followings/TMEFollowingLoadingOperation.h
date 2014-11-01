//
//  TMEFollowingLoadingOperation.h
//  ThreeMin
//
//  Created by Triệu Khang on 1/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMEFollowingLoadingOperation : NSObject
<
KHLoadingOperationProtocol
>

- (instancetype)initUserID:(NSUInteger)userID page:(NSUInteger)page;

@end
