//
//  TMEReachabilityManager.m
//  PhotoButton
//
//  Created by Toan Slan on 12/26/13.
//
//

#import "TMEReachabilityManager.h"

@implementation TMEReachabilityManager

OMNIA_SINGLETON_M(sharedInstance)

+ (BOOL)isReachable {
    return [[[TMEReachabilityManager sharedInstance] reachability] isReachable];
}

+ (BOOL)isUnreachable {
    return ![[[TMEReachabilityManager sharedInstance] reachability] isReachable];
}

+ (BOOL)isReachableViaWWAN {
    return [[[TMEReachabilityManager sharedInstance] reachability] isReachableViaWWAN];
}

+ (BOOL)isReachableViaWiFi {
    return [[[TMEReachabilityManager sharedInstance] reachability] isReachableViaWiFi];
}

- (id)init {
    self = [super init];
    if (self) {

    }
    
    return self;
}

- (void)setup
{
    // Initialize Reachability
    self.reachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    self.lastState = 1;
    
    // Start Monitoring
    [self.reachability startNotifier];
}


@end
