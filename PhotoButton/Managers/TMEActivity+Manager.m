//
//  TMEActivity+Manager.m
//  ThreeMin
//
//  Created by Triệu Khang on 25/4/14.
//
//

#import "TMEActivity+Manager.h"

@implementation TMEActivity (Manager)

+ (void)getActivitySuccess:(void(^)(NSArray *arrActivities))successBlock failure:(void(^)(NSError *error))failureBlock {

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager tme_manager];
    [manager GET:API_ACTIVITY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSMutableArray *arrResult = [@[] mutableCopy];

        for (NSDictionary *dict in responseObject) {
            TMEActivity *activity = [TMEActivity MR_createEntity];
            [activity activityFromDictionary:dict];
            [arrResult addObject:activity];
        }

        if (successBlock) {
            successBlock(arrResult);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];

}

@end
