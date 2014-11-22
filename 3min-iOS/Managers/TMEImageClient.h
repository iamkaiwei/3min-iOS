//
//  TMEImageClient.h
//  ThreeMin
//
//  Created by Khoa Pham on 11/22/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMEImageClient : NSObject

+ (void)getImageForURL:(NSURL *)url success:(TMEImageBlock)success failure:(TMEFailureBlock)failure;

@end
