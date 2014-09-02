//
//  TMEUsefulMacros.h
//  ThreeMin
//
//  Created by Khoa Pham on 7/17/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

//------------------------------------------------------------------------------------------------------

//
// Convenient macros
//

#define getrandom(min, max) ((rand()%(int)(((max) + 1)-(min)))+ (min))

//
// Convenient macro to check app version
//
#define APP_VERSION                                 ([[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey])
#define APP_VERSION_EQUAL_TO(v)                     ([APP_VERSION compare:v options:NSNumericSearch] == NSOrderedSame)
#define APP_VERSION_GREATER_THAN(v)                 ([APP_VERSION compare:v options:NSNumericSearch] == NSOrderedDescending)
#define APP_VERSION_GREATER_THAN_OR_EQUAL_TO(v)     ([APP_VERSION compare:v options:NSNumericSearch] != NSOrderedAscending)
#define APP_VERSION_LESS_THAN(v)                    ([APP_VERSION compare:v options:NSNumericSearch] == NSOrderedAscending)
#define APP_VERSION_LESS_THAN_OR_EQUAL_TO(v)        ([APP_VERSION compare:v options:NSNumericSearch] != NSOrderedDescending)

//
// Convenient macro to check system version
// Source: http://stackoverflow.com/questions/3339722/check-iphone-ios-version
//
#define SYSTEM_VERSION                              ([[UIDevice currentDevice] systemVersion])
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([SYSTEM_VERSION compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([SYSTEM_VERSION compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([SYSTEM_VERSION compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_IOS7_OR_ABOVE                            (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))

#define DEVICE_NAME                                 ([[UIDevice currentDevice] name])

#define IS_LANDSCAPE                                (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
#define IS_PORTRAIT                                 (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation))
#define IS_SIMULATOR                                ([[[UIDevice currentDevice] model] hasSuffix:@"Simulator"])
#define IS_IPAD                                     ([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad)
#define IS_NOT_IPAD                                 ([UIDevice currentDevice].userInterfaceIdiom!=UIUserInterfaceIdiomPad)
#define IS_RETINA                                   ([UIScreen mainScreen].scale > 1)
#define DEVICE_SCALE                                ([UIScreen mainScreen].scale)

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

//
// Source: http://iphoneincubator.com/blog/debugging/the-evolution-of-a-replacement-for-nslog
// Source: http://www.cimgf.com/2010/05/02/my-current-prefix-pch-file/
//
// DLog is almost a drop-in replacement for NSLog to turn off logging for release build
//
// add -DDEBUG to OTHER_CFLAGS in the build user defined settings
//
// Usage:
//
// DLog();
// DLog(@"here");
// DLog(@"value: %d", x);
// Unfortunately this doesn't work DLog(aStringVariable); you have to do this instead DLog(@"%@", aStringVariable);
//

#ifdef DEBUG
#define DLog(__FORMAT__, ...) NSLog((@"%s [L:%d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...) do {} while (0)
#endif

#define LS(string) NSLocalizedString(string, nil)

#define OMNIA_SINGLETON_H(name)     + (instancetype)name;
#define OMNIA_SINGLETON_M(name)     + (instancetype)name { static dispatch_once_t onceToken; static id instance = nil; dispatch_once(&onceToken, ^{ instance = [[self alloc] init]; }); return instance; }
