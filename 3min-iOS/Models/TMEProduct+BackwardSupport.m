//
//  TMEProduct+BackwardSupport.m
//  ThreeMin
//
//  Created by Triệu Khang on 15/7/14.
//
//

#import "TMEProduct+BackwardSupport.h"

@implementation TMEProduct (BackwardSupport)

- (BOOL)likedValue {
    return self.liked;
}

- (NSNumber *)id {
    return self.productID;
}

- (void)setLikedValue:(BOOL)liked {
    self.liked = liked;
}

- (void)likesDescrease {
    self.likes = @([self.likes integerValue] + 1);
}

- (void)likesIncrease {
    self.likes = @([self.likes integerValue] - 1);
}

@end
