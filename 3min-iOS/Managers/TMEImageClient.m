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


@end
