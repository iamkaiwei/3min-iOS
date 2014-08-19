//
//  TMEDeviceManager.h
//  ThreeMin
//
//  Created by Khoa Pham on 8/18/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMEDeviceManager : TMEBaseManager

OMNIA_SINGLETON_H(sharedManager)

@property (nonatomic, copy) NSString *UDID;

- (void)load;

@end
