//
//  TMEActivity+Manager.h
//  ThreeMin
//
//  Created by Triệu Khang on 25/4/14.
//
//

#import "TMEActivity.h"

@interface TMEActivity (Manager)

+ (void)getActivitySuccess:(void(^)(NSArray *arrActivities))successBlock failure:(void(^)(NSError *error))failureBlock;

@end
