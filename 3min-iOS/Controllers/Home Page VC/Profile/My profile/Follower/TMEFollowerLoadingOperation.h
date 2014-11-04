//
//  TMEFollowerLoadingOperation.h
//  ThreeMin
//
//  Created by Triệu Khang on 4/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMEFollowerLoadingOperation : NSObject
<
KHLoadingOperationProtocol
>

- (instancetype)initUserID:(NSUInteger)userID page:(NSUInteger)page;

@end
