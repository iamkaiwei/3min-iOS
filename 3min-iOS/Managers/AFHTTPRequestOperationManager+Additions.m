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
	    dispatch_queue_t completionQueue = dispatch_queue_create("AFNetworkingParsingResponseQueue", DISPATCH_QUEUE_CONCURRENT);
        // FIXME: Disable for now
	    //manager.completionQueue = completionQueue;

	    manager.responseSerializer = [AFJSONResponseSerializer serializer];
	    manager.requestSerializer = [AFJSONRequestSerializer serializer];
	});
	return manager;
}

+ (instancetype)tme_manager {
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager shareInstance];

    // add access token to the header of request
	NSString *access_token = [[TMEUserManager sharedInstance] getAccessToken];
	if (access_token) {
		NSString *authHeader = [NSString stringWithFormat:@"Bearer %@", access_token];
		[manager.requestSerializer setValue:authHeader
		                 forHTTPHeaderField:@"Authorization"];
	}
	return manager;
}

@end
