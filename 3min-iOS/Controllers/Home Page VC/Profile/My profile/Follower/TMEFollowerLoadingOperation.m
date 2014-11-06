//
//  TMEFollowerLoadingOperation.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEFollowerLoadingOperation.h"

@interface TMEFollowerLoadingOperation()

@property (assign, nonatomic) NSUInteger page;
@property (assign, nonatomic) NSUInteger userID;

@property (strong, nonatomic) NSArray *dataPage;

@end

@implementation TMEFollowerLoadingOperation

- (instancetype)initUserID:(NSUInteger)userID page:(NSUInteger)page {
    self = [super init];
    if (self) {
        _page = page;
        _userID = userID;
    }

    return self;
}

- (void)loadData:(void (^)(NSArray *, NSError *))finishBlock {
    __weak typeof(self)weakSelf = self;
    TMEUserNetworkClient *userClient = [[TMEUserNetworkClient alloc] init];
    [userClient getFollowersWithUserID:self.userID page:self.page success:^(NSArray *arrFollowings) {
        weakSelf.dataPage = arrFollowings;
        if (finishBlock) {
            finishBlock(arrFollowings, nil);
        }
    } failure:^(NSError *error) {
        if (finishBlock) {
            finishBlock(nil, error);
        }
    }];
}

@end
