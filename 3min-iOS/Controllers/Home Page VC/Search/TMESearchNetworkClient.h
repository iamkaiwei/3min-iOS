//
//  TMESearchNetworkClient.h
//  ThreeMin
//
//  Created by Khoa Pham on 8/29/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMESearchNetworkClient : NSObject

- (void)search:(NSString *)searchText sucess:(TMEArraySuccessBlock)success failure:(TMEFailureBlock)failure;

@end
