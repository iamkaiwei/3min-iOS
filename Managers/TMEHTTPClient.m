//
//  TMEHTTPClient.m
//  PhotoButton
//
//  Created by Triệu Khang on 23/9/13.
//
//

#import "TMEHTTPClient.h"

@implementation TMEHTTPClient


+ (instancetype)sharedClient
{
    static TMEHTTPClient *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[TMEHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:API_SERVER_HOST]];
    });
    
    return __sharedInstance;
}

+ (NSSet *)defaultAcceptableContentTypes;
{
    return [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    }
    
    return self;
}


@end
