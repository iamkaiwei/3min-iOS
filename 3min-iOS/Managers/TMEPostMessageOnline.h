//
//  TMEPostMessageOnline.h
//  ThreeMin
//
//  Created by iSlan on 11/5/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMEUserMessageParameter.h"

@interface TMEPostMessageOnline : NSObject

+ (void)postMessageWithParameter:(TMEUserMessageParameter *)parameter;

@end
