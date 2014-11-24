//
//  TMENetworkManager.h
//  ThreeMin
//
//  Created by Khoa Pham on 8/3/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEBaseManager.h"

typedef void (^TMENetworkManagerJSONResponseSuccessBlock)(id responseObject);
typedef void (^TMENetworkManagerArraySuccessBlock)(NSArray *models);
typedef void (^TMENetworkManagerModelSuccessBlock)(id model);
typedef void (^TMENetworkManagerFailureBlock)(NSError *error);

@interface TMENetworkManager : TMEBaseManager

OMNIA_SINGLETON_H(sharedManager)
OMNIA_SINGLETON_H(sharedImageManager)

@property (nonatomic, strong, readonly) AFHTTPRequestOperationManager *requestManager;

- (void)updateAuthorizationHeader;

- (void)get:(NSString *)path
     params:(NSDictionary *)params
    success:(TMENetworkManagerJSONResponseSuccessBlock)success
    failure:(TMENetworkManagerFailureBlock)failure;

- (void)post:(NSString *)path
     params:(NSDictionary *)params
    success:(TMENetworkManagerJSONResponseSuccessBlock)success
    failure:(TMENetworkManagerFailureBlock)failure;

- (void)put:(NSString *)path
     params:(NSDictionary *)params
    success:(TMENetworkManagerJSONResponseSuccessBlock)success
    failure:(TMENetworkManagerFailureBlock)failure;

- (void)delete:(NSString *)path params:(NSDictionary *)params
success:(TMENetworkManagerJSONResponseSuccessBlock)success
failure:(TMENetworkManagerFailureBlock)failure;

- (void)getModels:(Class)modelClass
             path:(NSString *)path
           params:(NSDictionary *)params success:(TMENetworkManagerArraySuccessBlock)success
          failure:(TMENetworkManagerFailureBlock)failure;

- (void)getModel:(Class)modelClass
            path:(NSString *)path
          params:(NSDictionary *)params success:(TMENetworkManagerModelSuccessBlock)success
         failure:(TMENetworkManagerFailureBlock)failure;

@end
