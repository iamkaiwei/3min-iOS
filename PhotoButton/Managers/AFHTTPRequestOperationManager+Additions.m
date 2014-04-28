//
//  AFHTTPRequestOperationManager+Additions.m
//  ThreeMin
//
//  Created by Triệu Khang on 26/4/14.
//
//



#import "AFHTTPRequestOperationManager+Additions.h"

@implementation AFHTTPRequestOperationManager (Additions)

+ (instancetype)tme_manager {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    NSString *access_token = [[TMEUserManager sharedInstance] getAccessToken];
    if (access_token) {
        NSString *authHeader = [NSString stringWithFormat:@"Bearer '%@'", access_token];
        [manager.requestSerializer setValue:authHeader
                         forHTTPHeaderField:@"Authorization"];
    }

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    return manager;
}

@end
