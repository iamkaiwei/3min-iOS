//
//  TMEHTTPClient.h
//  PhotoButton
//
//  Created by Triệu Khang on 23/9/13.
//
//

typedef void (^TMEJSONRequestSuccessBlock) (NSInteger statusCode, id obj);
typedef void (^TMEJSONRequestFailureBlock) (NSInteger statusCode, id obj);

typedef void (^TMERequestSuccessBlock) (NSInteger statusCode, id obj);
typedef void (^TMERequestFailureBlock) (NSInteger statusCode, id obj);

typedef void (^TMERequestProgressBLock) (NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile);

@interface TMEHTTPClient : AFHTTPClient

+ (instancetype)sharedClient;

@end
