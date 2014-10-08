//
//  TMEProductCommentNetworkClient.h
//  ThreeMin
//
//  Created by Khoa Pham on 10/6/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMEProduct;

@interface TMEProductCommentNetworkClient : NSObject

- (void)getCommentsForProduct:(TMEProduct *)product
                      success:(TMEArrayBlock)success
                      failure:(TMEErrorBlock)failure;

- (void)createCommentForProduct:(TMEProduct *)product
                        content:(NSString *)content
                     completion:(TMEBooleanBlock)completion;


@end
