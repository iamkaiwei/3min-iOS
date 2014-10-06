//
//  TMEProductLikeNetworkClient.h
//  ThreeMin
//
//  Created by Khoa Pham on 10/6/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMEProduct;

@interface TMEProductLikeNetworkClient : NSObject

- (void)getUsersThatLikeProduct:(TMEProduct *)product success:(TMEArrayBlock)success failure:(TMEErrorBlock)failure;

@end
