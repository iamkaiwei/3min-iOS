//
//  TMEReachabilityManager.h
//  PhotoButton
//
//  Created by Toan Slan on 12/26/13.
//
//

#import "BaseManager.h"
#import "Reachability.h"

@interface TMEReachabilityManager : BaseManager

@property (strong, nonatomic) Reachability *reachability;
@property (assign, nonatomic) NSInteger lastState;


+ (BOOL)isReachable;
+ (BOOL)isUnreachable;
+ (BOOL)isReachableViaWWAN;
+ (BOOL)isReachableViaWiFi;


@end
