//
//  TMEProductLikeViewModel.h
//  ThreeMin
//
//  Created by Khoa Pham on 10/6/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMEProductLikeViewModel : NSObject

- (instancetype)initWithProduct:(TMEProduct *)product;

@property (nonatomic, strong) NSArray *users;

- (void)pullUsers;

@end
