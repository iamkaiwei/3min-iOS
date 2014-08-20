//
//  NSObject+Additions.m
//
//  Created by Jesper Särnesjö on 2010-05-29.
//  Copyright 2010 Cartomapic. All rights reserved.
//

#import "NSObject+Additions.h"
#import <objc/runtime.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation NSObject (Additions)

- (id)ifKindOfClass:(Class)c
{
  return [self isKindOfClass:c] ? self : nil;
}

+ (void)exchangeMethod:(SEL)origSel withNewMethod:(SEL)newSel
{
  Class class = [self class];
  
  Method origMethod = class_getInstanceMethod(class, origSel);
  if (!origMethod){
    origMethod = class_getClassMethod(class, origSel);
  }
  if (!origMethod)
    @throw [NSException exceptionWithName:@"Original method not found" reason:nil userInfo:nil];
  Method newMethod = class_getInstanceMethod(class, newSel);
  if (!newMethod){
    newMethod = class_getClassMethod(class, newSel);
  }
  if (!newMethod)
    @throw [NSException exceptionWithName:@"New method not found" reason:nil userInfo:nil];
  if (origMethod==newMethod)
    @throw [NSException exceptionWithName:@"Methods are the same" reason:nil userInfo:nil];
  method_exchangeImplementations(origMethod, newMethod);
}

- (NSString *)getCurrentSSID
{
    NSString *currentSSID = nil;
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray == nil)
        return nil;
    
    NSDictionary* myDict = (__bridge NSDictionary *) CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
    if (myDict != nil)
        currentSSID = [myDict valueForKey:@"SSID"];
    
    return currentSSID;
}

- (BOOL)use3g
{
    BOOL use3g = YES;
    NSString *ssid = [[self getCurrentSSID] lowercaseString];
    if (ssid == nil || IS_SIMULATOR)
        use3g = NO;
    
    return use3g;
}


#pragma mark - Analytics

- (void)trackAnalyticsEventName:(NSString*)eventName
{
    [self trackAnalyticsEventName:eventName parameters:nil];
}

- (void)trackAnalyticsEventName:(NSString*)eventName parameters:(NSDictionary *)params
{
#ifndef PRODUCTION
    [Crashlytics setObjectValue:DEVICE_NAME forKey:@"Username"];
#endif
#ifdef PRODUCTION
    if ([EGCUserManager sharedInstance].currentUser)
        [Crashlytics setObjectValue:[[EGCUserManager sharedInstance].currentUser getDisplayName]] forKey:@"Username"];
#endif
    
//    NSMutableDictionary * eventAttributes = [[NSMutableDictionary alloc] init];
//    EGCUser * currentUser = [EGCUserManager sharedInstance].currentUser;
//    if (currentUser.ID != nil) {
//        if ([currentUser isChildUser])      [eventAttributes setObject:currentUser.ID forKey:STRING_ANALYTICS_CHILD_ID];
//        else                                [eventAttributes setObject:currentUser.ID forKey:STRING_ANALYTICS_PARENT_ID];
//    }
//    
//    if ([params count] > 0)
//        [eventAttributes addEntriesFromDictionary:params];
//    
//    if ([eventAttributes count] <= 0)       [[LocalyticsSession shared] tagEvent:eventName];
//    else                                    [[LocalyticsSession shared] tagEvent:eventName attributes:eventAttributes];
}

- (void)trackCritercismBreadCrumb:(NSUInteger)lineNumber
{
    /* Too inefficient if user rarely enter their profile information
     NSArray * profiles = [[ADStorageManager sharedInstance] getAllClassModelObject:[ADCustomer class]];
     if ([profiles count] > 0)
     {
     ADCustomer * customer = [profiles objectAtIndex:0];
     if ([customer.name length] > 0)       [Crittercism setUsername:customer.name];
     if ([customer.email length] > 0)      [Crittercism setEmail:customer.email];
     if ([customer.gender length] > 0)     [Crittercism setGender:customer.gender];
     if ([customer.ID integerValue] > 0)   [Crittercism setValue:[customer.ID stringValue] forKey:@"id"];
     }
     */
    
    NSString *breadcrumb = [NSString stringWithFormat:@"%@:%d", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], lineNumber];
    CLS_LOG(@"%@", breadcrumb);
}

@end
