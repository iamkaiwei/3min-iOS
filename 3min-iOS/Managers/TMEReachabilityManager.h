//
//  TMEReachabilityManager.h
//  PhotoButton
//
//  Created by Toan Slan on 12/26/13.
//
//

#import "Reachability.h"

@interface TMEReachabilityManager : TMEBaseManager

OMNIA_SINGLETON_H(sharedInstance)

@property (strong, nonatomic) Reachability *reachability;
@property (assign, nonatomic) NSInteger lastState;


+ (BOOL)isReachable;
+ (BOOL)isUnreachable;
+ (BOOL)isReachableViaWWAN;
+ (BOOL)isReachableViaWiFi;

- (void)setup;


@end
