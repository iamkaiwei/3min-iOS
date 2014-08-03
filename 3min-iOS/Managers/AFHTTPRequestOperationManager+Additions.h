//
//  AFHTTPRequestOperationManager+Additions.h
//  ThreeMin
//
//  Created by Triệu Khang on 26/4/14.
//
//

#import "AFHTTPRequestOperationManager.h"

@interface AFHTTPRequestOperationManager (Additions)

/**
 *  Return a custom manager
 *
 *  @return 
 *  Custom AFHTTPRequestOperationManger
 *
 *  @discussion
 *  This custom manager uses another queue to parse the response
 *  so maybe you have to jump to main thread to update UI
 */
+ (instancetype)tme_manager;

@end
