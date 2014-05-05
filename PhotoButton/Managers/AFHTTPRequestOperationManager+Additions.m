//
//  AFHTTPRequestOperationManager+Additions.m
//  ThreeMin
//
//  Created by Triệu Khang on 26/4/14.
//
//



#import "AFHTTPRequestOperationManager+Additions.h"

@implementation AFHTTPRequestOperationManager (Additions)

+ (instancetype)shareInstance {
    static AFHTTPRequestOperationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *url = [NSString stringWithFormat:@"%@%@", API_BASE_URL, API_PREFIX];
        manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    });
    return manager;
}

+ (instancetype)tme_manager {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager shareInstance];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    NSString *access_token = [[TMEUserManager sharedInstance] getAccessToken];
    if (access_token) {
        NSString *authHeader = [NSString stringWithFormat:@"Bearer %@", access_token];
        [manager.requestSerializer setValue:authHeader
                         forHTTPHeaderField:@"Authorization"];
    }

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    return manager;
}

@end
