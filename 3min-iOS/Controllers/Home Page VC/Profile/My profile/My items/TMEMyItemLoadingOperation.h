//
//  TMEMyItemLoadingOperation.h
//  ThreeMin
//
//  Created by Triệu Khang on 5/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMEMyItemLoadingOperation : NSObject
<
KHLoadingOperationProtocol
>

- (instancetype)initWithPage:(NSUInteger)page;

@end
