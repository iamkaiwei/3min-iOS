//
//  TMEProductLikeViewModel.m
//  ThreeMin
//
//  Created by Khoa Pham on 10/6/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductLikeViewModel.h"
#import "TMEProductLikeNetworkClient.h"

@interface TMEProductLikeViewModel ()

@property (nonatomic, strong) TMEProduct *product;

@end

@implementation TMEProductLikeViewModel

- (instancetype)initWithProduct:(TMEProduct *)product
{
    self = [super init];
    if (self) {
        _product = product;
    }

    return self;
}

- (void)pullUsers
{
    TMEProductLikeNetworkClient *client = [[TMEProductLikeNetworkClient alloc] init];
    [client getUsersThatLikeProduct:self.product success:^(NSArray *users) {
        self.users = users;
    } failure:^(NSError *error) {

    }];
}

@end
