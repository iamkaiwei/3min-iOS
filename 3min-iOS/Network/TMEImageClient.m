//
//  TMEImageClient.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/22/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEImageClient.h"

@implementation TMEImageClient

+ (void)getImageForURL:(NSURL *)url success:(TMEImageBlock)success failure:(TMEFailureBlock)failure
{
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];

    UIImage *cachedImage = [[UIImageView sharedImageCache] cachedImageForRequest:urlRequest];
    if (cachedImage) {
        if (success) {
            success(cachedImage);
        }
    } else {
       [[TMENetworkManager sharedImageManager] get:url.absoluteString params:nil success:^(id responseObject) {
           if (success) {
               success(responseObject);
           }
       } failure:^(NSError *error) {
           if (failure) {
               failure(error);
           }
       }];
    }
}

+ (void)uploadImages:(NSArray *)images
           path:(NSString *)path
             success:(TMESuccessBlock)success
             failure:(TMEFailureBlock)failure
{
    NSMutableArray *operations = [NSMutableArray array];

    AFHTTPRequestOperationManager *manager = [TMENetworkManager sharedManager].requestManager;
    NSString *URLString = [NSURL URLWithString:path relativeToURL:manager.baseURL].absoluteString;

    for (UIImage *image in images) {
        NSURLRequest *request = [manager.requestSerializer
                                 multipartFormRequestWithMethod:@"POST"
                                 URLString:URLString
                                 parameters:nil
                                 constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
        {
            NSData *data = UIImagePNGRepresentation(image);
            [formData appendPartWithFileData:data name:@"content" fileName:@"product_image.png" mimeType:@"image/png"];
        }];

        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [operations addObject:operation];
    }

    NSArray *batchedOperations = [AFURLConnectionOperation
                                  batchOfRequestOperations:operations
                                  progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations)
    {
        NSLog(@"%u of %u complete", numberOfFinishedOperations, totalNumberOfOperations);
    } completionBlock:^(NSArray *operations) {
        if (success) {
            success();
        }
    }];

    [manager.operationQueue addOperations:batchedOperations waitUntilFinished:NO];
}

@end
