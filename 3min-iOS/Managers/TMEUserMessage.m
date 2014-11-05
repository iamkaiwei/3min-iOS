//
//  TMEUserMessage.m
//  ThreeMin
//
//  Created by iSlan on 11/5/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEUserMessage.h"

@implementation TMEUserMessage

+ (void)postMessageWithParameter:(TMEUserMessageParameter *)paramater{
    if (paramater.postMode == TMEPostModeOnline) {
        [TMEPostMessageOnline postMessageWithParameter:paramater];
    }
    else {
        [TMEPostMessageOffline postMessageWithParameter:paramater];
    }
}

@end
