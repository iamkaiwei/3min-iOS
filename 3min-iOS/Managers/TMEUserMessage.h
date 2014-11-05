//
//  TMEUserMessage.h
//  ThreeMin
//
//  Created by iSlan on 11/5/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMEPostMessageOffline.h"
#import "TMEPostMessageOnline.h"

@interface TMEUserMessage : NSObject

+ (void)postMessageWithParameter:(TMEUserMessageParameter *)paramater;
    
@end
