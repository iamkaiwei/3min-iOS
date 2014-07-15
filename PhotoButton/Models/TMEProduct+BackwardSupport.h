//
//  TMEProduct+BackwardSupport.h
//  ThreeMin
//
//  Created by Triệu Khang on 15/7/14.
//
//

#import "TMEProduct.h"

@interface TMEProduct (BackwardSupport)

- (BOOL)likedValue;
- (NSNumber *)id;
- (void)setLikedValue:(BOOL)liked;

- (void)likesDescrease;
- (void)likesIncrease;

@end
