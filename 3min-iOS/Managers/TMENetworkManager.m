//
//  TMENetworkManager.m
//  ThreeMin
//
//  Created by Khoa Pham on 8/3/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMENetworkManager.h"
#import <AFNetworking/AFNetworking.h>

@interface TMENetworkManager ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;

@end

@implementation TMENetworkManager

+ (instancetype)sharedManager
{
    static TMENetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TMENetworkManager alloc] init];

        NSString *baseURLString = [NSString stringWithFormat:@"%@", API_BASE_URL];
        NSURL *baseURL = [NSURL URLWithString:baseURLString];
        instance.requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
        instance.requestManager.responseSerializer = [AFJSONResponseSerializer serializer];

        [instance updateAuthorizationHeader];
    });

    return instance;
}

+ (instancetype)sharedImageManager
{
    static TMENetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TMENetworkManager alloc] init];

        instance.requestManager = [AFHTTPRequestOperationManager manager];
        instance.requestManager.responseSerializer = [AFImageResponseSerializer serializer];

        [instance updateAuthorizationHeader];
    });

    return instance;
}

- (void)updateAuthorizationHeader
{
    // Authorization
    NSString *access_token = [TMEUserManager sharedManager].loggedUser.accessToken;
    if (access_token.length > 0) {
        NSString *authHeader = [NSString stringWithFormat:@"Bearer %@", access_token];
        [_requestManager.requestSerializer setValue:authHeader
                                 forHTTPHeaderField:@"Authorization"];
    }
}

- (void)get:(NSString *)path
     params:(NSDictionary *)params
    success:(TMENetworkManagerJSONResponseSuccessBlock)success
    failure:(TMENetworkManagerFailureBlock)failure
{
    [self.requestManager GET:path
                  parameters:params
                     success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)post:(NSString *)path
     params:(NSDictionary *)params
    success:(TMENetworkManagerJSONResponseSuccessBlock)success
    failure:(TMENetworkManagerFailureBlock)failure
{
    [self.requestManager POST:path
                  parameters:params
                     success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (success) {
             success(responseObject);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

- (void)put:(NSString *)path
     params:(NSDictionary *)params
    success:(TMENetworkManagerJSONResponseSuccessBlock)success
    failure:(TMENetworkManagerFailureBlock)failure
{
    [self.requestManager PUT:path
                  parameters:params
                     success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (success) {
             success(responseObject);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

- (void)delete:(NSString *)path
        params:(NSDictionary *)params
       success:(TMENetworkManagerJSONResponseSuccessBlock)success
       failure:(TMENetworkManagerFailureBlock)failure
{
    [self.requestManager DELETE:path
                     parameters:params
                        success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (success) {
             success(responseObject);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

- (void)getModels:(Class)modelClass
             path:(NSString *)path
           params:(NSDictionary *)params success:(TMENetworkManagerArraySuccessBlock)success
          failure:(TMENetworkManagerFailureBlock)failure
{
    [[TMENetworkManager sharedManager] get:path
                                    params:params
                                   success:^(id responseObject)
     {
         NSArray *models = [modelClass tme_modelsFromJSONResponse:responseObject];
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(models);
             });
         }
     } failure:^(NSError *error) {
         if (failure) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 failure(error);
             });
         }
     }];
}

- (void)getModel:(Class)modelClass
             path:(NSString *)path
           params:(NSDictionary *)params success:(TMENetworkManagerModelSuccessBlock)success
          failure:(TMENetworkManagerFailureBlock)failure
{
    [[TMENetworkManager sharedManager] get:path
                                    params:params
                                   success:^(id responseObject)
     {
         id model = [modelClass tme_modelFromJSONResponse:responseObject];
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(model);
             });
         }
     } failure:^(NSError *error) {
         if (failure) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 failure(error);
             });
         }
     }];
}

@end
