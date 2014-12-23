//
//  TMEUserItemsLoadingOperation.h
//  ThreeMin
//
//  Created by Vinh Nguyen on 22/12/2014.
//  Copyright (c) Năm 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMEUserItemsLoadingOperation : NSObject <KHLoadingOperationProtocol>
- (instancetype)initWithUserID:(NSUInteger)userID page:(NSUInteger)page;
@end
